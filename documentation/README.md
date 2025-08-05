# Documentation viewing

```bash
git clone https://github.com/laura-gen/ros2-project #Clone the Git repository
```

You should have:

ros2_project/
├── documentation/
│   ├── docs/
│   │   └── index.md    #Markdown file
│   ├── README.md
│   └── mkdocs.yml
│
├── ros2_jazzy_installation/
│   ├── Dockerfile         
│   ├── run_dev.sh   #Script to launch the docker
│   ├── .dockerignore   #Avoid copying unnecessary files into the build context
│
└── ros2_ws/
    ├── src/



```bash
sudo apt install mkdocs
cd ros2_project/documentation
mkdocs serve #Click on http://127.0.0.1:8000/ to see the documentation 
```
