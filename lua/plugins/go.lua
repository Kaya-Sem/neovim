return {

    require("which-key").add({
        {
            "<leader>b",
            ':!go build main.go<CR>',
            desc = "[B]uild Go Project",
            mode = "n"
        },
    })

}
