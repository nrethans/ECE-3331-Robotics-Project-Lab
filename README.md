# ECE-3331 Robotics Project Lab - Group 3

![FPGA](https://img.shields.io/badge/FPGA-Basys--3-blue)
![Language](https://img.shields.io/badge/Language-Verilog-orange)
![Course](https://img.shields.io/badge/Course-ECE--3331-green)
![Semester](https://img.shields.io/badge/Semester-Spring--2024-lightblue)

## 🤖 Project Overview

This repository contains the complete autonomous robotics system developed for ECE-3331 Robotics Project Lab. Our robot is designed for competitive ball-collecting and goal-scoring tasks, featuring advanced sensor fusion, intelligent control algorithms, and robust safety systems.

### Key Features
- 🎯 **Autonomous Ball Detection & Collection**
- ⚽ **Intelligent Goal Detection & Shooting**
- 🛡️ **Defensive Maneuvering Capabilities**
- 🔊 **Multi-Modal Sensor Fusion** (Microphone, IR, Ultrasonic)
- 🎮 **Dual-Mode Operation** (Attack/Defense)
- 📡 **Telemetry Mast with Distance Measurement**
- ⚡ **Real-time Control** via Basys-3 FPGA

## 🏗️ System Architecture

### Main State Machine
Our robot operates on a sophisticated 5-state finite state machine:

```
IDLE → BALL_DETECTION → GOAL_DETECTION → SHOOT → IDLE
  ↓
DEFENSE ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ← ←
```

### Core Components

#### 🎮 Control System
- **Main State Machine** (`MainStateMachine.v`) - Central decision making
- **Direction Control Modules** - Ball tracking, goal alignment, defense
- **Motor Control** - PWM-based dual-track drive system
- **Safety Systems** - Emergency stops and collision avoidance

#### 🔍 Sensor Suite
- **Microphone Array** - Dual-mic phase detection for ball direction
- **IR Sensors** - 1kHz/10kHz frequency detection for goals and balls
- **Ultrasonic** - Distance measurement and obstacle detection
- **Inductance Sensors** - Proximity and collision detection

#### ⚙️ Actuator Systems
- **Dual-Track Drive** - Independent left/right motor control
- **Kicker Mechanism** - Solenoid-based ball shooting
- **Telemetry Mast** - Servo-controlled positioning system

## 📁 Repository Structure

```
ECE-3331-Robotics-Project-Lab/
├── MainProject/                 # Main robot control system
│   ├── Main.v                  # Top-level module
│   ├── MainStateMachine/       # Central state machine
│   ├── DriveTrain/             # Motor control and movement
│   │   ├── DirectionControl/    # Ball tracking & navigation
│   │   ├── MotorPWM/           # PWM motor control
│   │   └── DisableHandler/     # Safety systems
│   ├── Sensors/                # Sensor processing modules
│   │   ├── Microphone/         # Audio-based ball detection
│   │   ├── IR/                 # Infrared sensors
│   │   └── Ultrasonic/         # Distance measurement
│   ├── KickerSolinoid/         # Ball shooting mechanism
│   └── Telemetry_Mast/         # Mast control and positioning
├── Nick/                       # Alternative implementations
│   └── ThinkandMotor/          # Advanced control algorithms
├── HardwareSchematics/         # Circuit designs and schematics
├── TestModules/               # Individual module testing
├── Templates/                 # Development templates
└── Useful Info/               # Documentation and pinouts
```

## 🚀 Getting Started

### Prerequisites
- **Vivado Design Suite** (Xilinx)
- **Basys-3 FPGA Board** (Artix-7)
- **Motor Drivers** (H-bridge)
- **Sensors**: Microphones, IR receivers, Ultrasonic sensors

### Hardware Setup
1. Connect Basys-3 FPGA to motor drivers via PMOD connectors
2. Install sensors according to pinout specifications
3. Connect power supply and verify voltage levels
4. Load bitstream to FPGA

### Software Development
1. Clone the repository
2. Open Vivado and create new project
3. Add all `.v` files to the project
4. Set constraints using provided `.xdc` files
5. Synthesize and implement design
6. Generate and program bitstream

## 🔧 Technical Specifications

### Motor Control
- **Drive System**: Dual-track differential drive
- **PWM Frequency**: 8kHz
- **Duty Cycles**: 40%, 50%, 75%, 100%
- **Direction Control**: Independent forward/backward

### Sensor Specifications
- **Microphone**: Phase detection for ball localization
- **IR Detection**: 1kHz (900-1200Hz), 10kHz (9000-11000Hz)
- **Ultrasonic**: Distance measurement with BCD display
- **Sampling Rate**: 100MHz system clock

### Safety Features
- **Emergency Stop**: Hardware disable switches
- **Collision Avoidance**: Inductance-based proximity detection
- **Overcurrent Protection**: Dual comparator circuits
- **Debounced Controls**: Prevents accidental triggers

## 🎯 Competition Modes

### Attack Mode
1. **Ball Detection** - Locate and track balls using microphone array
2. **Ball Collection** - Navigate to ball position
3. **Goal Detection** - Find target using IR sensors
4. **Shooting** - Execute kick with proper timing

### Defense Mode
1. **Threat Assessment** - Monitor opponent movements
2. **Positioning** - Move to defensive positions
3. **Blocking** - Intercept opponent shots
4. **Counter-Attack** - Transition to attack when opportunity arises

## 🧪 Testing & Validation

### Module Testing
Each module includes comprehensive testbenches:
- **Unit Tests** - Individual module verification
- **Integration Tests** - System-level validation
- **Edge Case Testing** - Boundary condition handling
- **Timing Analysis** - Real-time performance verification

### Hardware Testing
- **Basys-3 Board Testing** - FPGA functionality verification
- **Sensor Calibration** - Accuracy and range testing
- **Motor Performance** - Speed and torque validation
- **System Integration** - End-to-end functionality

## 👥 Team Members

**ECE-3331-303 Group 3 (Best Group)**
- **Nicholas Rethans** - Main State Machine, Drive Train Control
- **Samir Hossain** - Sensor Systems, Ultrasonic, Telemetry Mast

## 📚 Documentation

### Development Guidelines
- Use provided templates for new modules
- Include comprehensive testbenches
- Follow proper variable naming conventions
- Document all modules with author credits
- Test thoroughly before adding to build folder

### Resources
- [Verilog Tutorial](https://www.chipverify.com/tutorials/verilog)
- [Basys-3 Manual](https://digilent.com/reference/_media/reference/programmable-logic/basys-3/basys3_rm.pdf)
- [Artix-7 Data Sheet](https://docs.xilinx.com/v/u/en-US/ds181_Artix_7_Data_Sheet)

## 🐛 Debugging Tips

### Common Issues
1. **Synthesis Optimization** - Vivado may optimize away modules
2. **Clock Domain** - Always use `posedge` or `negedge` for clock signals
3. **IO Triggers** - Avoid using IO signals in always block triggers
4. **Initial Blocks** - Only work in simulation, not synthesis

### Debugging Steps
1. Check synthesis and implementation reports
2. Verify all modules are included and connected
3. Use proper clock constraints
4. Test individual modules before integration

## 📈 Future Enhancements

- [ ] **Machine Learning Integration** - AI-based decision making
- [ ] **Wireless Communication** - Remote monitoring and control
- [ ] **Advanced Navigation** - SLAM and path planning
- [ ] **Multi-Robot Coordination** - Team-based strategies
- [ ] **Real-time Telemetry** - Live performance monitoring

## 📄 License

This project is developed for educational purposes as part of ECE-3331 Robotics Project Lab at [University Name].

## 🤝 Contributing

This is a course project repository. For questions or suggestions, please contact the team members directly.

---

**"Bully Anti Dinga"** - Group 3 Motto 🎯

*Built with ❤️ and lots of Verilog*
