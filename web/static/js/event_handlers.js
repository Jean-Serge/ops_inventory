function synchronizeDroplets() {
    const xhttp = new XMLHttpRequest();
    xhttp.open("PATCH", "/api/synchronize_droplets", false);
    xhttp.setRequestHeader("Content-type", "application/json");
    xhttp.send();
    const response = JSON.parse(xhttp.responseText);
    console.log(response)
}

module.exports = {
    synchronizeDroplets
}