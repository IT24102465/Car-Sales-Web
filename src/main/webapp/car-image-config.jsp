<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String googleKey = application.getInitParameter("google.cse.key");
    if (googleKey == null) googleKey = "";
    String googleCx = application.getInitParameter("google.cse.cx");
    if (googleCx == null) googleCx = "";
    String imaginCustomer = application.getInitParameter("imagin.studio.customer");
    if (imaginCustomer == null) imaginCustomer = "";
    googleKey = googleKey.replace("\\", "\\\\").replace("'", "\\'");
    googleCx = googleCx.replace("\\", "\\\\").replace("'", "\\'");
    imaginCustomer = imaginCustomer.replace("\\", "\\\\").replace("'", "\\'");
%>
<script>
window.CAR_IMAGE_CONFIG = {
    googleKey: '<%= googleKey %>',
    googleCx: '<%= googleCx %>',
    imaginCustomer: '<%= imaginCustomer %>'
};
</script>
