var licence = {}

window.addEventListener("message", function (event) {

    if (event.data.action == "toggleUI") {
        toggleUI(event.data.state, event.data.licenses);
    }

});

function toggleUI(state, licenses) {

    licence = licenses

    if (state) {

        document.getElementById("menu").setAttribute("style", "display:flex;")

        //Driver License
        if (licenses[0]) {
            document.getElementById("dmv").classList.remove("grayout")
        } else {
            document.getElementById("dmv").classList.add("grayout")
        }

        //Weapon License
        if (licenses[1]) {
            document.getElementById("gun").classList.remove("grayout")
        } else {
            document.getElementById("gun").classList.add("grayout")
        }

    } else {
        document.getElementById("menu").setAttribute("style", "display:none;")
    }

}

function showID() {
    $.post('https://wg_idCard/show', JSON.stringify({ licens: "id" }));
}

function showLicens() {
    if (licence[0]) {
        $.post('https://wg_idCard/show', JSON.stringify({ licens: "dvm" }));
    } else {
        $.post('https://wg_idCard/err', JSON.stringify({ message: "~r~Du hast keinen Führerschein" }));
    }
}

function showGun() {
    if (licence[1]) {
        $.post('https://wg_idCard/show', JSON.stringify({ licens: "gun" }));
    } else {
        $.post('https://wg_idCard/err', JSON.stringify({ message: "~r~Du hast keinen Waffenschein" }));
    }
}

//Close UI function
document.onkeydown = function (data) {
    if (data.which == 27 || data.which == 73) {
        $.post('https://wg_idCard/escapeUI', JSON.stringify({}));
        return
    }
};