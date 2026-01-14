# MOVEIT: Montevideo Optimized Vehicular Efficiency via Intelligent Traffic

**Author**: Ignacio Machado | Cohort 24  
**Tags**: Reinforcement Learning, SUMO, Traffic Simulation, DDQN, SARSA, Urban Mobility

## Overview
The objective of this project is to enhance traffic flow at selected intersections in Montevideo using intelligent traffic light control. Traditional traffic signal systems rely on static timing plans that do not adapt to real-time demand, often leading to increased travel times, congestion, higher emissions, and elevated accident risk.

To address these limitations, this project implements reinforcement learning–based traffic signal controllers capable of dynamically adjusting signal timings based on observed traffic conditions. By continuously monitoring vehicle flows from multiple directions, the agent adapts phase durations to better match real-time demand and reduce congestion.

Adaptive traffic signal control has already shown promising results in Montevideo. In the Tres Cruces area, the deployment of a Full Adaptive traffic light system reduced travel times by approximately 5–10% during weekday peak hours and up to 20% on weekends. These results highlight the potential of data-driven approaches for urban traffic optimization.

Building on this context, MOVEIT provides a controlled simulation environment for implementing, evaluating, and comparing multiple reinforcement learning architectures—such as SARSA and Double Deep Q-Networks (DDQN)—under realistic and reproducible traffic scenarios.

## Project Structure

```text
MOVEIT/
├── notebooks/ # Colab/Jupyter notebooks for analysis
├── data/ # Raw and processed traffic data
├── SUMO_config/ # SUMO configuration files
├── results/ # Training outputs and generated plots
├── docs/ # Additional documentation
└── README.md # This file
```

## Installation & Usage

### Requirements
- Python 3.9+
- SUMO (Simulation of Urban Mobility)
- Conda or virtualenv recommended

### Setup
Clone the repository and install dependencies:

```bash
git clone https://github.com/yourusername/MOVEIT.git
cd MOVEIT
pip install -r requirements.txt
```

Alternatively, a preconfigured Conda environment is provided:
```bash
conda env create -f environment.yml
conda activate moveit
```

### Running the Simulation

Training and evaluation can be executed via the provided notebooks in notebooks/ or by running the corresponding Python scripts.

## Methodology
### Simulation Environment
In this project, selected intersections in Montevideo are recreated within a SUMO (Simulation of Urban Mobility) environment, accurately reflecting the geometry and layout of their real-world counterparts. Traffic conditions are simulated using real or representative data from different times of day and demand levels, creating realistic scenarios for training and evaluation.
### Traffic Signal Control Strategies
From the user’s perspective, the system presents a visual, interactive simulation of each intersection, where vehicles move through lanes in real time and traffic lights change dynamically. Users can observe animated vehicle flows, queue formation, and signal phase transitions directly within the simulation. Alongside the animation, the interface displays quantitative performance metrics such as average waiting time, queue length, vehicle throughput, stop frequency, and estimated emissions over time.
Multiple traffic signal control strategies can be evaluated within the same environment. These include a static traffic light controller representing the current fixed-time approach, as well as several adaptive reinforcement learning–based controllers. Different model architectures (such as DDQN, and adversarial approaches) and parameter configurations can be trained and tested under identical traffic scenarios. This allows users to observe how distinct learning strategies adapt signal timing in response to changing traffic demand and disturbances.
### Evaluation Framework
To validate performance, the system supports side-by-side comparisons across static control and multiple adaptive models. Performance graphs and summary statistics highlight differences in key indicators such as average travel time, congestion levels, queue stability, and robustness under varying demand patterns. This comparative framework enables a systematic assessment of which models and parameter settings provide the most effective and reliable traffic optimization.
After training, users can input custom traffic scenarios and immediately visualize the resulting signal behavior and performance metrics for each control strategy. This design enables an intuitive and transparent evaluation of how different adaptive traffic control methods compare not only to static approaches, but also to each other, under consistent and reproducible conditions.

## Results
TBD

## Project Timeline

### Week 1 – Simulation Environment and Baseline Control

During the first week, the selected traffic intersection(s) will be recreated within the SUMO simulation environment, capturing their geometry, lane configuration, and signal phases. A data pipeline will be implemented to inject traffic demand patterns—such as vehicle arrival rates and turning movements—into the simulator. Traffic light performance will then be evaluated using a fixed-time signal controller to establish a baseline. Key performance metrics, including average waiting time, queue length, and throughput, will be recorded for later comparison.

### Week 2 – Reinforcement Learning Controllers (SARSA and DDQN)

In the second week, reinforcement learning–based traffic signal controllers will be designed and integrated into the simulation environment. A common state representation, action space, and reward function will be defined to ensure fair comparison across methods. A tabular SARSA agent and a Double Deep Q-Network (DDQN) agent will be implemented and trained under normal traffic conditions. Initial experiments will validate learning stability and correct agent–environment interaction, with preliminary comparisons against the fixed-time baseline.

### Week 3 – Training, Hyperparameter Tuning, and Comparative Evaluation

The third week will focus on extended training and systematic evaluation of the SARSA and DDQN controllers. Hyperparameters will be tuned to improve convergence and performance. Both learning-based approaches will be quantitatively compared against the static baseline using unseen traffic scenarios. Performance will be assessed using standard traffic efficiency metrics, enabling analysis of learning speed, control effectiveness, and computational complexity.

### Week 4 – Adversarial Traffic Scenarios, Visualization, and Reporting

In the final week, adversarial traffic scenarios will be introduced to evaluate the robustness of each control strategy. These scenarios will simulate atypical or disruptive conditions—such as sudden traffic surges, lane blockages, or sensor noise—without retraining the models. Visualization tools and summary plots will be refined to enable clear, side-by-side comparison of fixed-time control, SARSA, and DDQN under both normal and stressed conditions. The final results will be analyzed and documented, highlighting trade-offs between efficiency, robustness, and model complexity, as well as outlining directions for future work.

## Data
- **Sample Data**: Small, processed files (`data/processed/`) are included for quick testing.
- **Full Raw Data**: Larger files must be downloaded separately.
    - **Source 1 (Speed)**: [Montevideo Average Speed Dataset](https://catalogodatos.gub.uy/dataset/velocidad-promedio-vehicular-en-las-principales-avenidas-de-montevideo)
    - **Source 2 (Volume)**: [Montevideo Vehicle Count Dataset](https://catalogodatos.gub.uy/dataset/conteo-vehicular-en-las-principales-avenidas-de-montevideo)
    - **Mirror (Convenience)**: [Google Drive Folder](https://drive.google.com/drive/folders/1cmOe9EN5kP0R22WODEO5KsUUtc-VuvLG?usp=drive_link) containing pre-selected files for this project.
- **Usage**: After downloading, place the required `.csv` files in the `data/raw/` directory and update the file path variable in the first cell of the notebook.
- **License**: Data is provided under the terms specified by "Catálogo Nacional de Datos Abiertos".


## Ethics & Safety

This project makes use of public, non-personal traffic data that does not contain sensitive or identifiable information. As a result, there are no ethical concerns related to data privacy, consent, or misuse of personal data.

This project is intended as a simulation-based evaluation and research tool and does not aim to directly control real-world traffic infrastructure.

However, despite being developed and evaluated within a simulated environment, the system is designed to model real-world traffic behavior. This introduces important ethical and safety considerations, as any traffic signal control system directly impacts driver safety. Consequently, the correctness and reliability of the model’s behavior take precedence over purely optimizing performance metrics such as waiting time or throughput.

Several critical safety constraints must be explicitly enforced. The traffic light controller is explicitly constrained to never allow conflicting traffic movements that could lead to collisions, and all signal transitions must follow established traffic regulations. In particular, transitions from green to red are required to include a yellow phase, whose duration is carefully defined based on vehicle speeds, driver reaction times, and braking distances. This ensures that drivers have sufficient time to perceive the signal change and safely come to a stop.

These safety constraints are treated as hard requirements rather than optimization objectives, meaning they cannot be violated by the learning agent, even if doing so would improve traffic efficiency. By prioritizing safety, regulatory compliance, and predictable behavior, the project aims to ensure that the resulting system is fair, responsible, and suitable for future real-world consideration.
