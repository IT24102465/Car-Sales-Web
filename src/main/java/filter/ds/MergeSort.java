package filter.ds;

public class MergeSort {
    public static <T extends Comparable<T>> void sort(LinkedList<T> list) {
        if (list.size() <= 1) return;

        int mid = list.size() / 2;
        LinkedList<T> left = list.subList(0, mid);
        LinkedList<T> right = list.subList(mid, list.size());

        sort(left);
        sort(right);
        merge(list, left, right);
    }

    private static <T extends Comparable<T>> void merge(
            LinkedList<T> result,
            LinkedList<T> left,
            LinkedList<T> right
    ) {
        // Clear the original list
        while (result.size() > 0) {
            result.remove(0);
        }

        // Get iterators
        LinkedList<T>.LinkedListIterator leftIt = left.iterator();
        LinkedList<T>.LinkedListIterator rightIt = right.iterator();

        T leftItem = leftIt.hasNext() ? leftIt.next() : null;
        T rightItem = rightIt.hasNext() ? rightIt.next() : null;

        // Merge logic
        while (leftItem != null && rightItem != null) {
            if (leftItem.compareTo(rightItem) <= 0) {
                result.add(leftItem);
                leftItem = leftIt.hasNext() ? leftIt.next() : null;
            } else {
                result.add(rightItem);
                rightItem = rightIt.hasNext() ? rightIt.next() : null;
            }
        }

        while (leftItem != null) {
            result.add(leftItem);
            leftItem = leftIt.hasNext() ? leftIt.next() : null;
        }

        while (rightItem != null) {
            result.add(rightItem);
            rightItem = rightIt.hasNext() ? rightIt.next() : null;
        }
    }
} 