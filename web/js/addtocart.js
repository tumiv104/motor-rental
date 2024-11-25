function addToCart(id) {
    $.ajax({
        url: "/clone/cart",
        type: "get", 
        data: {
            mid: id
        },
        success: function (mess) {
            var text = document.getElementById("" + id);
            text.innerHTML += mess;
            if (mess === "") {
                var cartBadge = document.getElementById("cart");
                cartBadge.innerText = parseInt(cartBadge.innerText) + 1;
            }
        },
        error: function (xhr) {
            //Do Something to handle error
        }
    });
}
