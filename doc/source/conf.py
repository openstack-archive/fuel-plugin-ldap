# Always use the default theme for Readthedocs
RTD_NEW_THEME = True

extensions = []
templates_path = ['_templates']

source_suffix = '.rst'

master_doc = 'index'

project = u'The LDAP plugin for Fuel'
copyright = u'2016, Mirantis Inc.'

version = '2.0-2.0.0-1'
release = '2.0-2.0.0-1'

exclude_patterns = []

pygments_style = 'sphinx'

html_theme = 'classic'
html_static_path = ['_static']

latex_documents = [
  ('index', 'LDAPPluginforFuel.tex',
   u'The LDAP plugin for Fuel documentation',
   u'Mirantis Inc.', 'manual'),
  ]

# make latex stop printing blank pages between sections
# http://stackoverflow.com/questions/5422997/sphinx-docs-remove-blank-pages-from-generated-pdfs
latex_elements = {'classoptions': ',openany,oneside', 'babel':
                  '\\usepackage[english]{babel}'}
