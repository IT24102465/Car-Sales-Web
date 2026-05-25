package filter.util;

import carsale.model.Car;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Resolves which make/model to use when searching the web for a car photo.
 * Listing text is often wrong (e.g. BMW + Camry); image filenames and brand rules fix that.
 */
public final class CarImageResolver {

    public static final String LOADING_PLACEHOLDER =
            "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='300'%3E"
                    + "%3Crect fill='%23e9ecef' width='400' height='300'/%3E"
                    + "%3Ctext x='50%25' y='50%25' dominant-baseline='middle' text-anchor='middle' "
                    + "fill='%236c757d' font-family='sans-serif' font-size='14'%3ELoading…%3C/text%3E%3C/svg%3E";

    private static final Pattern GENERIC_FILE = Pattern.compile(
            "^(img\\d*|car\\d*|car|placeholder|none|vishadi.*)$", Pattern.CASE_INSENSITIVE);

    private static final Map<String, String> MODEL_BRAND = new HashMap<>();

    private static final Map<String, String> MAKE_DEFAULT_MODEL = new HashMap<>();

    static {
        MODEL_BRAND.put("camry", "toyota");
        MODEL_BRAND.put("highlander", "toyota");
        MODEL_BRAND.put("corolla", "toyota");
        MODEL_BRAND.put("allion", "toyota");
        MODEL_BRAND.put("prius", "toyota");
        MODEL_BRAND.put("grace", "honda");
        MODEL_BRAND.put("civic", "honda");
        MODEL_BRAND.put("accord", "honda");
        MODEL_BRAND.put("fit", "honda");
        MODEL_BRAND.put("x5", "bmw");
        MODEL_BRAND.put("x3", "bmw");
        MODEL_BRAND.put("3 series", "bmw");
        MODEL_BRAND.put("leaf", "nissan");
        MODEL_BRAND.put("q5", "audi");
        MODEL_BRAND.put("a4", "audi");
        MODEL_BRAND.put("fusion", "ford");
        MODEL_BRAND.put("elantra", "hyundai");
        MODEL_BRAND.put("santa fe", "hyundai");

        MAKE_DEFAULT_MODEL.put("toyota", "Camry");
        MAKE_DEFAULT_MODEL.put("bmw", "X5");
        MAKE_DEFAULT_MODEL.put("honda", "Civic");
        MAKE_DEFAULT_MODEL.put("mercedes", "C-Class");
        MAKE_DEFAULT_MODEL.put("mercedes-benz", "C-Class");
        MAKE_DEFAULT_MODEL.put("audi", "A4");
        MAKE_DEFAULT_MODEL.put("ford", "Fusion");
        MAKE_DEFAULT_MODEL.put("hyundai", "Elantra");
        MAKE_DEFAULT_MODEL.put("nissan", "Altima");
    }

    private CarImageResolver() {}

    public static String escapeAttr(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                .replace("\"", "&quot;")
                .replace("<", "&lt;")
                .replace(">", "&gt;");
    }

    public static String getSearchMake(Car car) {
        return escapeAttr(resolveSearchTerms(car)[0]);
    }

    public static String getSearchModel(Car car) {
        return escapeAttr(resolveSearchTerms(car)[1]);
    }

    // Replace the section in resolveSearchTerms after the hint parsing:

    public static String[] resolveSearchTerms(Car car) {
        if (car == null) {
            return new String[]{"", ""};
        }
        String listingMake = safe(car.getMake());
        String listingModel = safe(car.getModel());

        String[] fromHint = parseHintFromFilename(extractImageFilename(car.getImages()), listingMake);
        if (fromHint != null) {
            if (fromHint[0].equalsIgnoreCase(listingMake)) {
                String owner = MODEL_BRAND.get(listingModel.toLowerCase(Locale.ROOT));
                if (owner != null && owner.equalsIgnoreCase(listingMake)) {
                    return new String[]{titleCase(listingMake), titleCase(listingModel)};
                }
            }
            return fromHint;
        }

        String make = titleCase(listingMake);
        String model = titleCase(listingModel);

        // If the model definitively belongs to a different brand (e.g. "BMW Camry", "Audi Highlander"),
        // use the CORRECT brand for image searching instead of the listing make's default model.
        // This ensures CarImageOverrides.resolvedKey() finds the right override entry.
        String owner = MODEL_BRAND.get(listingModel.toLowerCase(Locale.ROOT));
        if (owner != null && !owner.equalsIgnoreCase(listingMake)) {
            return new String[]{titleCase(owner), model};   // ← [Toyota, Camry] / [Toyota, Highlander]
            // OLD code was: look up MAKE_DEFAULT_MODEL[listingMake] and return [listingMake, fallback]
            // That caused "BMW Highlander" → [BMW, X5] and "Audi Highlander" → [Audi, A4]
        }

        // Handle internal codes like H200, H300 — fall back to make's representative model
        if (listingModel.matches("(?i)h\\d+")) {
            String fallback = MAKE_DEFAULT_MODEL.get(listingMake.toLowerCase(Locale.ROOT));
            if (fallback != null) {
                model = fallback;
            }
        }

        return new String[]{make, model};
    }

    public static String buildSearchQuery(Car car) {
        String[] terms = resolveSearchTerms(car);
        StringBuilder q = new StringBuilder();
        if (car != null && car.getYear() != null && !car.getYear().trim().isEmpty()) {
            q.append(car.getYear().trim()).append(' ');
        }
        q.append(terms[0]).append(' ').append(terms[1]).append(" car exterior");
        return q.toString().trim();
    }

    public static boolean shouldReplaceStoredImage(String images) {
        return true;
    }

    @Deprecated
    public static String resolveForCar(Car car) {
        return LOADING_PLACEHOLDER;
    }

    static String extractImageFilename(String images) {
        if (images == null || images.trim().isEmpty() || "none".equalsIgnoreCase(images.trim())) {
            return "";
        }
        String name = images.split(",")[0].trim();
        int dot = name.lastIndexOf('.');
        if (dot > 0) {
            name = name.substring(0, dot);
        }
        name = name.replaceAll("(?i)\\s*-\\s*copy\\s*$", "").trim();
        name = name.replaceAll("[()]", " ").replaceAll("\\s+", " ").trim();
        return name;
    }

  private static String[] parseHintFromFilename(String hint, String listingMake) {
        if (hint == null || hint.isEmpty() || GENERIC_FILE.matcher(hint).matches()) {
            return null;
        }
        String h = hint.toLowerCase(Locale.ROOT);

        if (h.contains("x5") || h.contains("x 5") || h.contains("bmw.x5")) {
            return alignHintWithListing(pair("BMW", "X5"), listingMake);
        }
        if (h.contains("civic")) {
            return alignHintWithListing(pair("Honda", "Civic"), listingMake);
        }
        if (h.contains("corolla")) {
            return alignHintWithListing(pair("Toyota", "Corolla"), listingMake);
        }
        if (h.contains("grace")) {
            return alignHintWithListing(pair("Honda", "Grace"), listingMake);
        }
        if (h.contains("leaf") && !"toyota".equalsIgnoreCase(listingMake)) {
            return alignHintWithListing(pair("Nissan", "Leaf"), listingMake);
        }
        if (h.contains("allion")) {
            return alignHintWithListing(pair("Toyota", "Allion"), listingMake);
        }
        if (h.contains("highlander")) {
            return alignHintWithListing(pair("Toyota", "Highlander"), listingMake);
        }
        if (h.contains("camry") && !h.contains("bmw") && !h.contains("mercedes")) {
            return alignHintWithListing(pair("Toyota", "Camry"), listingMake);
        }
        if (h.contains("audi")) {
            return alignHintWithListing(pair("Audi", h.contains("q5") ? "Q5" : "A4"), listingMake);
        }
        if (h.contains("mercedes") || h.contains("benz")) {
            return alignHintWithListing(pair("Mercedes-Benz", "C-Class"), listingMake);
        }

        Matcher wordModel = Pattern.compile(
                "(bmw|toyota|honda|nissan|ford|hyundai|audi|mercedes)\\s*[-.]?\\s*([a-z0-9][a-z0-9\\s]{0,20})",
                Pattern.CASE_INSENSITIVE).matcher(hint);
        if (wordModel.find()) {
            String make = titleCase(wordModel.group(1));
            if ("mercedes".equalsIgnoreCase(wordModel.group(1))) {
                make = "Mercedes-Benz";
            }
            String modelPart = wordModel.group(2).trim();
            if (!modelPart.isEmpty() && !GENERIC_FILE.matcher(modelPart).matches()) {
                return alignHintWithListing(pair(make, titleCase(modelPart)), listingMake);
            }
        }

        return null;
    }

    private static String[] alignHintWithListing(String[] hint, String listingMake) {
        if (hint == null || listingMake == null || listingMake.isEmpty()) {
            return hint;
        }
        String owner = MODEL_BRAND.get(hint[1].toLowerCase(Locale.ROOT));
        if (owner != null
                && !owner.equalsIgnoreCase(listingMake)
                && !hint[0].equalsIgnoreCase(listingMake)) {
            String fallback = MAKE_DEFAULT_MODEL.get(listingMake.toLowerCase(Locale.ROOT));
            if (fallback != null) {
                return pair(titleCase(listingMake), fallback);
            }
        }
        return hint;
    }

    private static String[] pair(String make, String model) {
        return new String[]{make, model};
    }

    private static String safe(String s) {
        return s == null ? "" : s.trim();
    }

    private static String titleCase(String s) {
        if (s == null || s.isEmpty()) {
            return "";
        }
        String[] parts = s.trim().split("\\s+");
        StringBuilder out = new StringBuilder();
        for (int i = 0; i < parts.length; i++) {
            if (i > 0) {
                out.append(' ');
            }
            String p = parts[i];
            if (p.length() == 1) {
                out.append(p.toUpperCase(Locale.ROOT));
            } else if (p.length() <= 3 && p.matches("[a-z0-9]+")) {
                out.append(p.toUpperCase(Locale.ROOT));
            } else {
                out.append(Character.toUpperCase(p.charAt(0)))
                        .append(p.substring(1).toLowerCase(Locale.ROOT));
            }
        }
        return out.toString();
    }
}
