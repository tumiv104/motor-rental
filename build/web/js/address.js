$(document).ready(function () {
    $('#province').on('change', function () {
        var province_id = $(this).val();
        if (province_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "get", 
                dataType: "json",
                data: {
                    province_id: province_id
                },
                success: function (data) {
                    $('#district').empty();
                    $('#district').append($('<option>').val("").text("--Chọn quận/huyện--"));
                    $.each(data, function (i, district) {
                        $('#district').append($('<option>').val(district.id).text(district.name));
                    });
                    $('#ward').empty();
                    $('#ward').append($('<option>').val("").text("--Chọn xã/phường--"));
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
            $('#ward').empty();
            $('#ward').append($('<option>').val("").text("--Chọn xã/phường--"));
        } else {
            $('#district').empty();
            $('#district').append($('<option>').val("").text("--Chọn quận/huyện--"));
            $('#ward').empty();
            $('#ward').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });

    $('#district').on('change', function () {
        var district_id = $(this).val();
        if (district_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "post", 
                dataType: "json",
                data: {
                    district_id: district_id
                },
                success: function (data) {
                    $('#ward').empty();
                    $('#ward').append($('<option>').val("").text("--Chọn xã/phường--"));
                    $.each(data, function (i, ward) {
                        $('#ward').append($('<option>').val(ward.id).text(ward.name));
                    });
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
        } else {
            $('#ward').empty();
            $('#ward').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });
    
    
    $('#province2').on('change', function () {
        var province_id = $(this).val();
        if (province_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "get", 
                dataType: "json",
                data: {
                    province_id: province_id
                },
                success: function (data) {
                    $('#district2').empty();
                    $('#district2').append($('<option>').val("").text("--Chọn quận/huyện--"));
                    $.each(data, function (i, district) {
                        $('#district2').append($('<option>').val(district.id).text(district.name));
                    });
                    $('#ward2').empty();
                    $('#ward2').append($('<option>').val("").text("--Chọn xã/phường--"));
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
            $('#ward2').empty();
            $('#ward2').append($('<option>').val("").text("--Chọn xã/phường--"));
        } else {
            $('#district2').empty();
            $('#district2').append($('<option>').val("").text("--Chọn quận/huyện--"));
            $('#ward2').empty();
            $('#ward2').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });

    $('#district2').on('change', function () {
        var district_id = $(this).val();
        if (district_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "post", 
                dataType: "json",
                data: {
                    district_id: district_id
                },
                success: function (data) {
                    $('#ward2').empty();
                    $('#ward2').append($('<option>').val("").text("--Chọn xã/phường--"));
                    $.each(data, function (i, ward) {
                        $('#ward2').append($('<option>').val(ward.id).text(ward.name));
                    });
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
        } else {
            $('#ward2').empty();
            $('#ward2').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });
    $('#province3').on('change', function () {
        var province_id = $(this).val();
        if (province_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "get", 
                dataType: "json",
                data: {
                    province_id: province_id
                },
                success: function (data) {
                    $('#district3').empty();
                    $('#district3').append($('<option>').val("").text("--Chọn quận/huyện--"));
                    $.each(data, function (i, district) {
                        $('#district3').append($('<option>').val(district.id).text(district.name));
                    });
                    $('#ward3').empty();
                    $('#ward3').append($('<option>').val("").text("--Chọn xã/phường--"));
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
            $('#ward3').empty();
            $('#ward3').append($('<option>').val("").text("--Chọn xã/phường--"));
        } else {
            $('#district3').empty();
            $('#district3').append($('<option>').val("").text("--Chọn quận/huyện--"));
            $('#ward3').empty();
            $('#ward3').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });

    $('#district3').on('change', function () {
        var district_id = $(this).val();
        if (district_id) {
            $.ajax({
                url: "/clone/districtward",
                type: "post",
                dataType: "json",
                data: {
                    district_id: district_id
                },
                success: function (data) {
                    $('#ward3').empty();
                    $('#ward3').append($('<option>').val("").text("--Chọn xã/phường--"));
                    $.each(data, function (i, ward) {
                        $('#ward3').append($('<option>').val(ward.id).text(ward.name));
                    });
                },
                error: function (xhr) {
                    //Do Something to handle error
                }
            });
        } else {
            $('#ward3').empty();
            $('#ward3').append($('<option>').val("").text("--Chọn xã/phường--"));
        }
    });
});