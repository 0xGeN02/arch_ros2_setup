# Commands and Usage

## Docker comands

```sh
docker run -it --user ${USERNAME} --name ${NAME} ${CONTAINER_NAME}

docker build -t ${CONTAINER_NAME} .

docker image ls

docker ps -a

docker rm ${CONTAINER_NAME}

docker rm ${docker ps -a}
```

## ROS2:Humble and Gazebo:Harmonic Commands

### Init ROS2

```sh
# Source the ROS 2 setup script
source /opt/ros/humble/setup.bash

# Initialize rosdep
sudo rosdep init
rosdep update
```

#### Commands ROS2

```sh
# Create a new ROS 2 package
ros2 pkg create <package_name>

# Build the workspace
colcon build

# Source the workspace
source install/setup.bash

# List available nodes
ros2 node list

# Run a node
ros2 run <package_name> <node_name>

# List available topics
ros2 topic list

# Echo a topic
ros2 topic echo <topic_name>

# List available services
ros2 service list

# Call a service
ros2 service call <service_name> <service_type> "{<request_parameters>}"
```

#### Gazebo:Harmonic Commands

```sh
# Launch Gazebo
gz sim

# Spawn a model in Gazebo
gz sim -s <model_name>

# List available models
gz model list

# Pause simulation
gz sim -p

# Unpause simulation
gz sim -u

# Reset simulation
gz sim -r

# Take a screenshot
gz sim -screenshot <file_name>
```

#### RQT Commands

```sh
# Launch RQT
rqt

# Launch RQT with a specific plugin
rqt --standalone <plugin_name>

# List available plugins
rqt --list-plugins
```
