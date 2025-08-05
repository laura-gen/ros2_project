
<h1 style="text-align: center;"><u>Docker ROS2 Jazzy Jalisco</u></h1>


<br>

##### *Using Docker for ROS2 Jazzy Jalisco on Windows11 using WSL2 to install Ubuntu.*

<br>

> More details about [Docker for ROS](https://blog.robotair.io/the-complete-beginners-guide-to-using-docker-for-ros-2-deployment-2025-edition-0f259ca8b378)

> Unable to send ur_script or ROS commands to the robot. Possible reasons: Docker is running on Ubuntu so sending commands takes too long. 

<br>

## table of contents 

- [Advantages of using Docker](#advantages-of-using-docker)
- [Setting up the environment and documentation viewing](#setting-up-the-environment-and-documentation-viewing)
- [Installation of Docker Desktop on Windows 11](#installation-of-docker-desktop-on-windows-11)
- [Installation of VS Code](#installation-of-vs-code)
- [Installation of Ubuntu on Windows11 via WSL2](#installation-of-ubuntu-on-windows11-via-wsl2)
- [Robot UR3e, PolysCope 5.11 and computer configuration](#robot-ur3e-polyscope-511-and-computer-configuration)
- [Launch driver](#launch-driver)


<br>

---


# Advantages of using Docker

Docker guarantees identical behavior of the ROS2 stack, regardless of the computer used.  
Docker also allows dependencies to be isolated, meaning that as many containers as desired can be launched: for example, ROS2 Jazzy and ROS2 Humble can be run on the same machine.  
The Docker container is an isolated virtual environment, so there will be no changes to the host system. 

<br>

---

# Setting up the environment and documentation viewing

##### Setting up the environment

```bash
git clone https://github.com/laura-gen/ros2-project #Clone the Git repository
```

You should have:

```bash
ros2_project/
├── documentation/
│   ├── docs/
│   │   └── index.md    #Markdown file
│   └── mkdocs.yml
│
├── ros2_jazzy_installation/
│   ├── Dockerfile         
│   ├── run_dev.sh   #Script to launch the docker
│   ├── .dockerignore   #Avoid copying unnecessary files into the build context
│
└── ros2_ws/
    ├── src/
```

##### Documentation viewing

```bash
sudo apt install mkdocs
cd ros2_project/documentation
mkdocs serve #Click on http://127.0.0.1:8000/ to see the documentation 
```

<br>

---

# Installation of Docker Desktop on Windows 11

- Download [Docker Desktop 4.43.1 for Windows](https://docs.docker.com/desktop/release-notes/)
- Double-click Docker Desktop Installer.exe to run the installer
- Follow the instructions of the installation 
- When the installation is successful, select Close to complete the installation process
- Open Docker
- Create a log in Docker 
- Check the installation of Docker in a PowerShell:
```powershell
docker run hello-world
```

<br>

---
# Installation of VS Code

Install [VS Code](https://code.visualstudio.com/) for Windows 


<br>

---
# Installation of Ubuntu on Windows11 via WSL2

- Open PowerShell :
```powershell
wsl --install #WSL2 is installed by default
```

- Restart the computer 
- Open Ubuntu
- Create a default Unix user and a new password

<br>

---

# Launch the Docker 


```bash
cd ~/ros2_project/ros2_jazzy_installation
chmod +x run_dev.sh #Make the file executable
#Open Docker 
./run_env.sh #Build the image, launch the container and mount the host workspace ros2_ws into the container
cd /root/ros2_ws
colcon build
source install/setup.bash #No need to run this command in future new terminals because it is written in the bashrc file (see the Dockerfile) 
```
<br>

##### A few commands for Docker

- Exit Docker without closing the terminal: press Ctrl+P, then Ctrl+Q.

- Reconnect with the docker: 
```bash
docker exec -it ros2_container bash
```

- List running containers: 
```bash
docker ps #You should see : image :"ros2_jazzy_ubuntu24"
```

<br>

---
# Robot UR3e, PolysCope 5.11 and computer configuration 
##### Setting up the Universal Robot ur3e on the same local network as the computer

**On the PolyScope:**  

- Go to the menu (the three bars at top right) → Settings → System → Network  
- Check information about the network of the robot:  
<p style="padding-left: 40px;"> - Static Address is selected </p>  
<p style="padding-left: 40px;"> - IP address = 192.168.1.101</p>  
<p style="padding-left: 40px;"> - Subnet mask = 255.255.255.0</p>


**On a computer terminal**, check if the computer IP address is 
in 192.168.1.x form and identify Ethernet interface &lt;eth0&gt; by which robot and computer are connected via ethernet cable: 
```bash
ip a
```

If the IP address is not in 192.168.1.x form, assign an IP address <192.168.1.102> to the computer
```bash
sudo ip addr flush dev eth0 #Delete all IP addresses associated with network interface <eth0>.
sudo ip addr add 192.168.1.102/24 dev eth0 #Assign IP address <192.168.1.102> with mask 255.255.255.0 to interface <eth0>.
```

**On PolyScope :**   

- Go to Installation → URCaps → External Control   
- Set Host IP with the IP of the computer <192.168.1.102>  
- Save  

**In the Docker**, check the connexion with the robot : 
```bash
apt update 
apt install -y iputils-ping #Installation of ping 
ping 192.168.1.101 #If you get "64 bytes from 192.168.1.101: icmp_seq=1 ttl=64 time= ... ms ...", the connection is right
```

<br>

---

# Launch driver
```bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur3e robot_ip:=ur3e
```

If you get "Receive program failed" on the PolyScope when trying to launch the External-control program, check Windows firewalls:  
**On PolyScope :**  
- Go to Installation → URCaps → External Control     
- Check the Custom port: 50002  
**On Windows :**  
- Open Control Panel → System and Security → Windows Defender Firewall  
- Click Advanced Settings    
- Go to Inbound Rules    
- Check that your Windows firewall allows port 50002 for incoming TCP traffic if not add a new rule:
<p style="padding-left: 40px;"> - Rule Type: Port</p>
<p style="padding-left: 40px;"> - Protocol and Ports: TCP, Specific local ports: 50002</p>
<p style="padding-left: 40px;"> - Action: Allow the connection</p>
<p style="padding-left: 40px;"> - Profile: All</p>
<p style="padding-left: 40px;"> - Name: ROS2 External Control</p>











