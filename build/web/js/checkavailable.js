$(document).ready(function () {
                $('#address1').hide();
                $('#address2').hide();
                $('#startDate, #endDate').on('input', function () {
                    $('#alert1').empty();
                    var startDate = $('#startDate').val();
                    var endDate = $('#endDate').val();
                    if (startDate && endDate) {
                        $.ajax({
                            url: "/clone/checkavailable",
                            type: "get",
                            data: {
                                startDate: startDate,
                                endDate: endDate
                            },
                            success: function (data) {
                                $('#alert1').html(data.toString());
                            },
                            error: function (xhr) {
                                // Xử lý lỗi
                            }
                        });
                    }

                });
                $('#visibility1').val('hide').change(function () {
                    $('#address1').toggle();
                });
                $('#visibility2').val('hide').change(function () {
                    $('#address2').toggle();
                });
            });
            
            
