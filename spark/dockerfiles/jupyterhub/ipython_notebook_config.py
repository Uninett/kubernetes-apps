# Configuration file for ipython-notebook.

c = get_config()

#------------------------------------------------------------------------------
# NotebookApp configuration
#------------------------------------------------------------------------------

c.IPKernelApp.pylab = 'inline'
c.NotebookApp.ip = 'localhost'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8000
c.NotebookApp.base_url = '/ipython/'
c.NotebookApp.base_kernel_url = '/ipython/'
c.NotebookApp.trust_xheaders = True
c.NotebookApp.tornado_settings = {'static_url_prefix': '/ipython/static/'}
c.NotebookApp.notebook_dir = '/notebooks'
c.NotebookApp.allow_origin = '*'
