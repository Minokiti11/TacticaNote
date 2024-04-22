window.onload = function() {
    console.log("it's a modal.js");
    let modal_open = document.getElementById("modal-open-btn");
    modal_open.onclick = function () {
        $('#overlay').fadeIn();
        document.getElementById('modal-close-btn').onclick = function () {
            $('#overlay').fadeOut();
        };
        document.getElementById("delete-comformation-btn").onclick = function () {
            document.getElementById("item-delete-btn").click();
        };
    };
};
