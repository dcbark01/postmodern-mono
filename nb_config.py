import os
from pathlib import Path


c.ServerApp.ip = "0.0.0.0"  # noqa: F821
c.ServerApp.open_browser = False  # noqa: F821
c.IdentityProvider.token = ""  # noqa: F821
c.ServerApp.password = ""
c.ServerApp.allow_remote_access = True  # noqa: F821
c.ServerApp.port = int(os.getenv("JUPYTER_PORT", 8888))  # noqa: F821
c.ServerApp.root_dir = str(Path(__file__).parent.resolve())  # noqa: F821
