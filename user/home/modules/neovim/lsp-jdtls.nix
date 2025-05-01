{java, jdt, lombok, ...}:
''
-- Java Stuff
-- Searching Root Files
local root_files = {
  'build.xml',           -- Ant
  'pom.xml',             -- Maven
  'settings.gradle',     -- Gradle
  'settings.gradle.kts', -- Gradle
  'build.gradle',
  'build.gradle.kts',
}

-- Some Path
local current_root = vim.fs.dirname(vim.fs.find(root_files, {stop = vim.env.HOME})[1])
local java_home = '${java}/lib/openjdk' -- Your JDK
local jdtls_home = '${jdt}'
local jdtls_default_config = jdtls_home .. '/share/java/jdtls/config_linux/config.ini'
local jdtls_data_path = vim.fn.expand('$HOME/.config/jdtls/workspace/')
if current_root then
  jdtls_data_path = vim.fn.expand('$HOME/.config/jdtls/workspace/') .. current_root
end
local jdtls_config_path = vim.fn.expand('$HOME/.config/jdtls/config')
local jdtls_plugin_path = jdtls_home .. '/share/java/jdtls/plugins/'
local jdtls_jar_path = vim.fn.globpath(jdtls_plugin_path, 'org.eclipse.equinox.launcher_*.jar')
local java_path = java_home .. '/bin/java'

local jdtls_server = {
  capabilities = capabilities,
  cmd = {
    java_path,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dosgi.sharedConfiguration.area=' .. jdtls_default_config,
    '-Dosgi.sharedConfiguration.area.readOnly=true',
    '-Dosgi.checkConfiguration=true',
    '-Dosgi.configuration.cascaded=true',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. '${lombok}/share/java/lombok.jar',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jdtls_jar_path,
    '-configuration', jdtls_config_path,
    '-data', jdtls_data_path,
  },
  settings = {
    java = {
      home = java_home,
      project = {
        encoding = "UTF-8",
      },
      errors = {
        incompleteClasspath = {
          severity = "warning"
        }
      },
      trace = {
        server = "verbose"
      },
      import = {
        enabled = true,
        gradle = {
          enabled = true
        },
        maven = {
          enabled = true
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**"
        },
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      saveActions = {
        organizeImports = true
      },
      contentProvider = {
        preferred = "fernflower"
      },
      autobuild = {
        enabled = false
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "org.graalvm.*",
          "jdk.*",
          "sun.*",
        },
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        maven = {
          userSettings = vim.fn.expand("~/.m2/settings.xml"),
          globalSettings = vim.fn.expand("~/.m2/settings.xml"),
        },
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "'$'{object.className}{'$'{member.name()}='$'{member.value}, '$'{otherMembers}}",
        },
        useBlocks = true,
      },
    },
    flags = {
      allow_incremental_sync = true,
    },
  },
}
require('lspconfig').jdtls.setup(jdtls_server)
''
