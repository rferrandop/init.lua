local cmp_nvim_lsp = require('cmp_nvim_lsp')
local jdtls = require('jdtls')

local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local lombok_jar = vim.fn.stdpath('data') .. "/lombok.jar"

local function get_config_dir()
  if vim.fn.has('linux') == 1 then
    return 'config_linux'
  elseif vim.fn.has('mac') == 1 then
    return 'config_mac'
  else
    return 'config_win'
  end
end

local function get_workspace_dir()
    local cwd = vim.fn.getcwd()
    local project_name = vim.fn.fnamemodify(cwd, ":t") -- Get the project folder name
    local parent_dir = vim.fn.fnamemodify(cwd, ":h:t")   -- Get the parent directory

    if project_name == "server" then
        return parent_dir  -- If in a server subdirectory, return the parent as workspace
    else
        return cwd  -- Otherwise, use the current directory as workspace
    end
end

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

local config = {
    capabilities = capabilities,
    cmd = {
        'java',

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx4g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        '-javaagent:/Users/raulf/.local/share/nvim/lombok.jar',
        '-jar', launcher_jar,
        '-configuration', vim.fs.normalize(jdtls_path .. "/" .. get_config_dir()),
        '-data', vim.fn.expand('~/.cache/nvim/jdtls/') .. get_workspace_dir()

    },
    init_options = {
        extendedClientCapabilities = jdtls.extendedClientCapabilities
    },
    root_dir = vim.fs.dirname(vim.fs.find({".gradlew", ".git", ".mvnw"}, { upward= true})[1]),
    settings = {
        java = {
            eclipse = {
                downloadSources = true
            },
            maven = {
                downloadSources = true
            },
        }
    },
    on_attach = function (client, bufnr)
        local opts = { silent = true, buffer = bufnr }

        vim.keymap.set('n', "<leader>lo", jdtls.organize_imports, { desc = "Organize imports", buffer = bufnr })
    end
}

jdtls.start_or_attach(config)
