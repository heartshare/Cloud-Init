<div id="header" align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Bash_Logo_Colored.svg/512px-Bash_Logo_Colored.svg.png?20180723054350" width="100"/>
</div>

<div id="header" align="left">
  <h1>
  Cloud Init image for Proxmox
</h1>
</div>

<div>
   <img src="https://www.svgrepo.com/show/355338/ubuntu.svg" title="Ubuntu"  alt="Ubuntu" width="35" height="35"/>&nbsp;
  <img src="https://www.svgrepo.com/show/331552/proxmox.svg" title="Proxmox" **alt="Proxmox" width="35" height="35"/>&nbsp;
</div>  

:bookmark_tabs: Description:

This script was created to provision a template for Proxmox, based on Ubuntu 22.04 LTS (Cloud - Init) img.

The code uses the concept of functions a lot, which allows us, at the end of it, to put the order in which they will be executed.

Code segmented into stages, each with its description and functions, to make the code easier to read, understand and maintain in the future.

<div>
   <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Bash_Logo_Colored.svg/512px-Bash_Logo_Colored.svg.png?20180723054350" title="Bash"  alt="Bash" width="40" height="40"/>&nbsp;
</div>  

:pushpin: Requirements:

:computer: 1 - Access to the Proxmox Hypervisor.  
:shell: 2 - Shell Access.

:low_brightness: Execute:

<div>
   <img src="https://cdn-icons-png.flaticon.com/512/3079/3079162.png" title="Arduino"  alt="Arduino" width="40" height="40"/>&nbsp;
</div>

Download and run script. "Sh" and "Curl".
sh -c "$(curl -fsSL https://github.com/782e616c6d/Cloud-Init/blob/master/Ubuntu-CI.sh)" 

<div>
   <img src="https://iconmonstr.com/wp-content/g/gd/makefg.php?i=../releases/preview/2018/png/iconmonstr-medium-4.png&r=0&g=0&b=0" title="Medium"  alt="Medium" width="40" height="40"/>&nbsp;
</div>  

:point_right: Medium Link: 
https://medium.com/@tech.adson/cloud-init-and-proxmox-12d679337e4b
:point_left:
