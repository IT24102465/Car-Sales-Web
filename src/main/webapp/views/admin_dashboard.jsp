<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/car-certification.css">
    <style>
        .table td {
            vertical-align: middle;
        }
        .damage-text {
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
            cursor: pointer;
        }
        .action-buttons .btn {
            margin-bottom: 3px;
            width: 100%;
        }
        .tooltip-inner {
            max-width: 300px;
            text-align: left;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp"><i class="fas fa-car"></i>SMART CARZONE</a>
            <div class="ml-auto">
                <a href="admin-logout" class="btn btn-light btn-sm">
                    <i class="fas fa-sign-out-alt mr-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>
    
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-tachometer-alt mr-2"></i>Admin Dashboard</h2>
        </div>
        
        <div class="card mb-4">
            <div class="card-header bg-primary text-white">
                <i class="fas fa-clipboard-list mr-2"></i> Certification Requests
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-striped table-hover mb-0">
                        <thead class="thead-light">
                            <tr>
                                <th style="width: 8%">Brand</th>
                                <th style="width: 8%">Model</th>
                                <th style="width: 5%">Year</th>
                                <th style="width: 7%">Mileage</th>
                                <th style="width: 7%">Price</th>
                                <th style="width: 10%">Location</th>
                                <th style="width: 10%">Contact</th>
                                <th style="width: 15%">Damages</th>
                                <th style="width: 10%">Status</th>
                                <th style="width: 10%">Date</th>
                                <th style="width: 10%">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% 
                            List<Map<String, String>> requests = (List<Map<String, String>>) request.getAttribute("requests");
                            if (requests != null && !requests.isEmpty()) {
                                for (int i = 0; i < requests.size(); i++) {
                                    Map<String, String> req = requests.get(i);
                        %>
                            <tr class="request-row" data-request-id="<%= i %>">
                                <td><%= req.get("Brand") %></td>
                                <td><%= req.get("Model") %></td>
                                <td><%= req.get("Year") %></td>
                                <td><%= req.get("Mileage") %></td>
                                <td><%= req.get("Price") %></td>
                                <td><%= req.get("Location") %></td>
                                <td><%= req.get("Owner Contact") %></td>
                                <td>
                                    <div class="damage-text" data-toggle="tooltip" data-placement="top" 
                                         title="<%= req.get("Damages") %>">
                                        <%= req.get("Damages") %>
                                    </div>
                                </td>
                                <td>
                                    <% if ("Pending Approval".equals(req.get("Status"))) { %>
                                        <span class="badge badge-warning"><i class="fas fa-clock mr-1"></i><%= req.get("Status") %></span>
                                    <% } else if ("Approved".equals(req.get("Status"))) { %>
                                        <span class="badge badge-success"><i class="fas fa-check mr-1"></i><%= req.get("Status") %></span>
                                    <% } else { %>
                                        <span class="badge badge-danger"><i class="fas fa-times mr-1"></i><%= req.get("Status") %></span>
                                    <% } %>
                                </td>
                                <td><%= req.get("Submission Date").substring(0, 10) %></td>
                                <td>
                                    <% if ("Pending Approval".equals(req.get("Status"))) { %>
                                    <div class="action-buttons">
                                        <form action="admin-dashboard" method="post">
                                            <input type="hidden" name="index" value="<%= i %>">
                                            <button name="action" value="approve" class="btn btn-success btn-sm">
                                                <i class="fas fa-check mr-1"></i>Approve
                                            </button>
                                            <button name="action" value="reject" class="btn btn-danger btn-sm mt-1">
                                                <i class="fas fa-times mr-1"></i>Reject
                                            </button>
                                        </form>
                                    </div>
                                    <% } else { %>
                                        <span class="text-muted">No Action</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% 
                                }
                            } else { 
                        %>
                            <tr><td colspan="11" class="text-center py-4">
                                <i class="fas fa-info-circle mr-2"></i>No requests found.
                            </td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Modal for detailed certification request view -->
    <div class="modal fade" id="requestDetailModal" tabindex="-1" role="dialog" aria-labelledby="requestDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="requestDetailModalLabel">Certification Request Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <i class="fas fa-car mr-2"></i> Vehicle Information
                                </div>
                                <div class="card-body">
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Brand:</label>
                                        <div class="col-sm-8" id="modal-brand"></div>
                                    </div>
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Model:</label>
                                        <div class="col-sm-8" id="modal-model"></div>
                                    </div>
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Year:</label>
                                        <div class="col-sm-8" id="modal-year"></div>
                                    </div>
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Mileage:</label>
                                        <div class="col-sm-8" id="modal-mileage"></div>
                                    </div>
                                    <div class="form-group row mb-0">
                                        <label class="col-sm-4 font-weight-bold">Price:</label>
                                        <div class="col-sm-8" id="modal-price"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card">
                                <div class="card-header bg-info text-white">
                                    <i class="fas fa-info-circle mr-2"></i> Additional Information
                                </div>
                                <div class="card-body">
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Location:</label>
                                        <div class="col-sm-8" id="modal-location"></div>
                                    </div>
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Contact:</label>
                                        <div class="col-sm-8" id="modal-contact"></div>
                                    </div>
                                    <div class="form-group row mb-2">
                                        <label class="col-sm-4 font-weight-bold">Status:</label>
                                        <div class="col-sm-8" id="modal-status"></div>
                                    </div>
                                    <div class="form-group row mb-0">
                                        <label class="col-sm-4 font-weight-bold">Date:</label>
                                        <div class="col-sm-8" id="modal-date"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header bg-info text-white">
                            <i class="fas fa-exclamation-triangle mr-2"></i> Damages Report
                        </div>
                        <div class="card-body">
                            <div id="modal-damages" class="border p-3 bg-light" style="white-space: pre-wrap;"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer" id="modal-footer-actions">
                    <!-- Action buttons will be added here dynamically if status is pending -->
                </div>
            </div>
        </div>
    </div>
    
    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <p>&copy; 2025 CarCert Service - All Rights Reserved</p>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip({
                html: true
            });
            
            // Show full damages text when clicking on truncated text
            $('.damage-text').click(function() {
                $(this).toggleClass('text-truncate');
            });
            
            // Store all request data in JavaScript for modal population
            var requestsData = [
                <% 
                if (requests != null && !requests.isEmpty()) {
                    for (int i = 0; i < requests.size(); i++) {
                        Map<String, String> req = requests.get(i);
                %>
                {
                    brand: "<%= req.get("Brand") %>",
                    model: "<%= req.get("Model") %>",
                    year: "<%= req.get("Year") %>",
                    mileage: "<%= req.get("Mileage") %>",
                    price: "<%= req.get("Price") %>",
                    location: "<%= req.get("Location") %>",
                    contact: "<%= req.get("Owner Contact") %>",
                    damages: "<%= req.get("Damages").replace("\n", "\\n").replace("\"", "\\\"") %>",
                    status: "<%= req.get("Status") %>",
                    date: "<%= req.get("Submission Date") %>"
                }<%= (i < requests.size() - 1) ? "," : "" %>
                <% 
                    }
                } 
                %>
            ];
            
            // Make table rows clickable to show request details
            $('.request-row').click(function() {
                var requestId = $(this).data('request-id');
                showRequestDetails(requestId);
            });
            
            // Function to show request details in modal
            function showRequestDetails(requestId) {
                var request = requestsData[requestId];
                
                // Populate modal with request data
                $('#modal-brand').text(request.brand);
                $('#modal-model').text(request.model);
                $('#modal-year').text(request.year);
                $('#modal-mileage').text(request.mileage);
                $('#modal-price').text(request.price);
                $('#modal-location').text(request.location);
                $('#modal-contact').text(request.contact);
                $('#modal-damages').text(request.damages);
                
                // Status with badge
                var statusHtml = '';
                if (request.status === 'Pending Approval') {
                    statusHtml = '<span class="badge badge-warning"><i class="fas fa-clock mr-1"></i>' + request.status + '</span>';
                } else if (request.status === 'Approved') {
                    statusHtml = '<span class="badge badge-success"><i class="fas fa-check mr-1"></i>' + request.status + '</span>';
                } else {
                    statusHtml = '<span class="badge badge-danger"><i class="fas fa-times mr-1"></i>' + request.status + '</span>';
                }
                $('#modal-status').html(statusHtml);
                
                $('#modal-date').text(request.date.substring(0, 10));
                
                // Handle action buttons in modal footer
                $('#modal-footer-actions').empty();
                if (request.status === 'Pending Approval') {
                    var actionsHtml = `
                        <form action="admin-dashboard" method="post">
                            <input type="hidden" name="index" value="${requestId}">
                            <button name="action" value="approve" class="btn btn-success">
                                <i class="fas fa-check mr-1"></i>Approve
                            </button>
                            <button name="action" value="reject" class="btn btn-danger ml-2">
                                <i class="fas fa-times mr-1"></i>Reject
                            </button>
                        </form>
                    `;
                    $('#modal-footer-actions').html(actionsHtml);
                }
                
                // Show the modal
                $('#requestDetailModal').modal('show');
            }
        });
    </script>
</body>
</html>
