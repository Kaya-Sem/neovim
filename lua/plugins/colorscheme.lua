return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
        require('onedark').setup {
            style = 'warmer'
        }
        -- Enable theme
        require('onedark').load()
    end
}
