$("#bt").on('click', async () => {
    return await fetch($("#inp").val())
        .then(response => response.text())
        .then(response => $("#inp").put(response))
        .catch(e => console.warn(e))
})