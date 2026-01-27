# MOVEIT: Montevideo Optimized Vehicular Efficiency via Intelligent Traffic

**Author**: Ignacio Machado | Cohort 24 Holberton School
**Tags**: Reinforcement Learning, SUMO, Traffic Simulation, DDQN, SARSA, Urban Mobility

## Overview
The objective of this project is to enhance traffic flow at selected intersections in Montevideo using intelligent traffic light control. Traditional traffic signal systems rely on static timing plans that do not adapt to real-time demand, often leading to increased travel times, congestion, higher emissions, and elevated accident risk.

To address these limitations, this project implements reinforcement learning–based traffic signal controllers capable of dynamically adjusting signal timings based on observed traffic conditions. By continuously monitoring vehicle flows from multiple directions, the agent adapts phase durations to better match real-time demand and reduce congestion.

Adaptive traffic signal control has already shown promising results in Montevideo. In the Tres Cruces area, the deployment of a Full Adaptive traffic light system reduced travel times by approximately 5–10% during weekday peak hours and up to 20% on weekends. These results highlight the potential of data-driven approaches for urban traffic optimization.

Building on this context, MOVEIT provides a controlled simulation environment for implementing, evaluating, and comparing multiple reinforcement learning architectures—such as SARSA and Double Deep Q-Networks (DDQN)—under realistic and reproducible traffic scenarios.

## Project Structure

```text
MOVEIT/
├── notebooks/ # Colab/Jupyter notebooks for running code
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
- Conda or virtualenv (optional, recommended)

If you do not have Python 3.9 installed, download it from:
https://www.python.org/downloads/release/python-390/

If you use Conda, create a Python 3.9 environment:

```bash
conda create -n moveit python=3.9
conda activate moveit
```

### SUMO Installation

This project requires **SUMO ≥ 1.19**.

- **Windows & macOS:**  
  Download from the official site:  
  https://www.eclipse.org/sumo/

- **Linux (Ubuntu/Debian):**
```bash
  sudo apt install sumo sumo-tools sumo-doc
```

### Setup
Clone the repository and install dependencies:

```bash
git clone https://github.com/hexNulgath/ML---Portfolio-Project
cd ML---Portfolio-Project
```

Alternatively, a pre-configured Conda environment is provided:
```bash
conda env create -f environment.yml
conda activate moveit
```

or install the required modules:
```bash
pip install -r requirements.txt
```

### Data
> **Important:** To run the preprocessing and generate a new simulation file, you must download the raw data files listed below. In the first notebook cell, set `INPUT_CSV_PATH` to the file location, and assign `CSV_SPEED` and `CSV_VOLUME` to the corresponding filenames provided in the **Full Raw Data** section below.

- **Sample Data**: Small, processed files (`data/processed/`) are included for quick testing.
- **Full Raw Data**: Larger files must be downloaded separately.
    - **Source 1 (Speed)**: [Montevideo Average Speed Dataset](https://catalogodatos.gub.uy/dataset/velocidad-promedio-vehicular-en-las-principales-avenidas-de-montevideo)
    - **Source 2 (Volume)**: [Montevideo Vehicle Count Dataset](https://catalogodatos.gub.uy/dataset/conteo-vehicular-en-las-principales-avenidas-de-montevideo)
    - **Mirror (Convenience)**: [Google Drive Folder](https://drive.google.com/drive/folders/1cmOe9EN5kP0R22WODEO5KsUUtc-VuvLG?usp=drive_link) containing pre-selected files for this project.
- **Usage**: After downloading, place the required `.csv` files in the `data/raw/` directory and update the file path variable in the first cell of the notebook.
- **License**: Data is provided under the terms specified by "Catálogo Nacional de Datos Abiertos".


### Running the Simulation

Training and evaluation are executed through the provided notebooks in the `notebooks/` directory.

The first cell under Simulation RL defines the global variables used across the simulation and training process. To run a training experiment, it is necessary to set each variable including the first for setting the chosen model and run the full code underneath.

All reinforcement learning models share the same core pipeline for:

- environment initialization,

- reward computation,

- state construction, and

- base network creation.

Only the execution flow differs between models.
To run an experiment, set up the global variables and execute the whole code block.

## Methodology
### Simulation Environment
In this project, selected intersections in Montevideo are recreated within a SUMO (Simulation of Urban Mobility) environment, accurately reflecting the geometry and layout of their real-world counterparts. Traffic conditions are simulated using real or representative data from different times of day and demand levels, creating realistic scenarios for training and evaluation.
### Traffic Signal Control Strategies
From the user’s perspective, the simulation can be visualized through the SUMO graphical interface, allowing users to observe vehicle flows, queue formation, and signal phase transitions in real time. Alongside the animation, the interface displays quantitative performance metrics such as average waiting time, queue length, vehicle throughput, stop frequency, and estimated emissions over time.
Multiple traffic signal control strategies can be evaluated within the same environment. These include a static traffic light controller representing the current fixed-time approach, as well as several adaptive reinforcement learning–based controllers. Different model architectures (such as DDQN and SARSA) and stress testing scenarios can be trained and tested under identical traffic scenarios. This allows users to observe how distinct learning strategies adapt signal timing in response to changing traffic demand and disturbances.
### Evaluation Framework
To validate performance, the system supports side-by-side comparisons across static control and multiple adaptive models. Performance graphs and summary statistics highlight differences in key indicators such as average travel time, congestion levels, queue stability, and robustness under varying demand patterns. This comparative framework enables a systematic assessment of which models and parameter settings provide the most effective and reliable traffic optimization.
After training, users can input custom traffic scenarios and immediately visualize the resulting signal behavior and performance metrics for each control strategy. This design enables an intuitive and transparent evaluation of how different adaptive traffic control methods compare not only to static approaches, but also to each other, under consistent and reproducible conditions.

## Results

The performance of the traffic signal controllers was evaluated under a fixed-demand scenario using four key metrics: cumulative reward, mean queue length, mean waiting time, and spillback frequency. Three main controllers were compared: a static fixed-time controller, a SARSA-based adaptive controller, and a Double Deep Q-Network (DDQN) controller.

### Static Baseline
The static traffic light controller represents a non-adaptive fixed-cycle policy. Its performance was:

- Reward: −2497  
- Mean queue length: 3.49 vehicles  
- Mean waiting time: 3.55 seconds  
- Spillback frequency: 15 occurrences  

Although the static controller achieved relatively low waiting times, it produced the highest queue accumulation and spillback frequency, indicating poor global congestion management and lack of responsiveness to traffic fluctuations.

### Best SARSA Configuration (SARSA-13)
The best SARSA model achieved:

- Reward: −1481  
- Mean queue length: 1.87 vehicles  
- Mean waiting time: 1.63 seconds  
- Spillback frequency: 9 occurrences  

This configuration provided the strongest overall performance, with minimal waiting time, low queue accumulation, and significantly reduced spillback events. SARSA demonstrated stable convergence and consistent improvement across training iterations.

### Best DDQN Configuration (DDQN-06)
The best DDQN model achieved:

- Reward: −1570  
- Mean queue length: 2.41 vehicles  
- Mean waiting time: 5.12 seconds  
- Spillback frequency: 9 occurrences  

DDQN achieved strong global congestion control and low spillback frequency, outperforming the static baseline and approaching SARSA performance. However, DDQN exhibited higher sensitivity to hyperparameter tuning and required careful regularization to avoid policy degradation.

### Comparative Summary

| Controller | Reward | Mean Queue | Mean Wait | Spillback |
|------------|--------|------------|-----------|-----------|
| Static     | −2497  | 3.49       | 3.55      | 15        |
| SARSA-13   | −1481  | 1.87       | 1.63      | 9         |
| DDQN-06    | −1570  | 2.41       | 5.12      | 9         |

Overall, both reinforcement learning approaches significantly outperformed the static controller. SARSA achieved the best overall balance between efficiency and stability, while DDQN demonstrated strong potential but higher sensitivity to training dynamics.

## Project Timeline

### Week 1 – Simulation Environment and Baseline Control

During the first week, the selected traffic intersection(s) were recreated within the SUMO simulation environment, capturing their geometry, lane configuration, and signal phases. A data pipeline was implemented to inject traffic demand patterns into the simulator, and a fixed-time traffic light controller was evaluated to establish a baseline. Key performance metrics, including average waiting time, queue length, and throughput, were recorded for later comparison.

### Week 2 – Reinforcement Learning Controllers (SARSA and DDQN)

In the second week, reinforcement learning–based traffic signal controllers were designed and integrated into the simulation environment. A common state representation, action space, and reward function were defined to ensure fair comparison across methods. A tabular SARSA agent and a Double Deep Q-Network (DDQN) agent were implemented and trained under normal traffic conditions. Initial experiments validated learning stability and correct agent–environment interaction, with preliminary comparisons against the fixed-time baseline.

### Week 3 – Training, Hyperparameters Tuning, and Comparative Evaluation

The third week focused on extended training and systematic evaluation of the SARSA and DDQN controllers. Hyperparameters were tuned to improve convergence and performance. Both learning-based approaches were quantitatively compared against the static baseline using unseen traffic scenarios. Performance was assessed using standard traffic efficiency metrics, enabling analysis of learning speed, control effectiveness, and computational complexity.

### Week 4 – Stress and High-Demand Traffic Scenarios, Visualization, and Reporting

In the final week, stress and high-demand traffic scenarios were introduced to evaluate the robustness of each control strategy. These scenarios simulated atypical or disruptive conditions—such as sudden traffic surges, lane blockages, or sensor noise—without retraining the models. Visualization tools and summary metrics were refined to enable clear, side-by-side comparison of fixed-time control, SARSA, and DDQN under both normal and stressed conditions. The final results were analyzed and documented, highlighting trade-offs between efficiency, robustness, and model complexity.

## Ethics & Safety

This project makes use of public, non-personal traffic data that does not contain sensitive or identifiable information. As a result, there are no ethical concerns related to data privacy, consent, or misuse of personal data.

This project is intended as a simulation-based evaluation and research tool and does not aim to directly control real-world traffic infrastructure.

However, despite being developed and evaluated within a simulated environment, the system is designed to model real-world traffic behavior. This introduces important ethical and safety considerations, as any traffic signal control system directly impacts driver safety. Consequently, the correctness and reliability of the model’s behavior take precedence over purely optimizing performance metrics such as waiting time or throughput.

Several critical safety constraints must be explicitly enforced. The traffic light controller is explicitly constrained to never allow conflicting traffic movements that could lead to collisions, and all signal transitions must follow established traffic regulations. In particular, transitions from green to red are required to include a yellow phase, whose duration is carefully defined based on vehicle speeds, driver reaction times, and braking distances. This ensures that drivers have sufficient time to perceive the signal change and safely come to a stop.

These safety constraints are treated as hard requirements rather than optimization objectives, meaning they cannot be violated by the learning agent, even if doing so would improve traffic efficiency. By prioritizing safety, regulatory compliance, and predictable behavior, the project aims to ensure that the resulting system is fair, responsible, and suitable for future real-world consideration.
