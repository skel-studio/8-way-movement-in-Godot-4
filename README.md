# 8-way movement in Godot 4.x

<img src="https://img.shields.io/badge/Godot-4.x-%2523478cbf" alt="">

<a href="https://drive.google.com/file/d/1OKjWYZHzxAk7-bTCeyuwRMerKYizqnnY/view?usp=drive_link">Demo</a>

<p>This script controls the main character in a 2D game, implementing movement, animations, health system, and death handling.</p>
<h2>Key Features</h2>
<p>Exported Variables (Editable in Inspector)</p>
<ul>
    <li><b>hp</b> (int): Character's current health (default: 100)</li>
    <li><b>max_hp</b> (int): Maximum health capacity (default: 100)</li>
    <li><b>speed</b> (int): Movement speed in units per second (default: 15)</li>
</ul>

<h2>Internal Variables</h2>
<ul>
    <li><b>condition</b>: Character's current state (<i>idle</i>, <i>walk</i>, <i>dead</i>, <i>corpse</i>)</li>
    <li><b>direction</b>: Facing direction (<i>up</i>, <i>down</i>, <i>right</i>)</li>
    <li><b>die</b>: Death flag (true/false)</li>
    <li><b>player_animated</b>: Reference to AnimatedSprite2D node</li>
</ul>

<h2>Core Methods</h2>
<i>_ready()</i>
<ul>
    <li>Connects animation finished signal to handler</li>
</ul>
    
<i>_physics_process(delta)</i>
<ul>
    <li>Main game loop:
        <ul>
            <li>Checks health status</li>
            <li>Updates health</li>
            <li>Handles movement</li>
            <li>Updates animations</li>
            <li>Applies movement using move_and_slide()</li>
        </ul>
    </li>
</ul>

<i>hp_player()</i>
<ul>
    <li>Clamps current health to max_hp value</li>
</ul>

<i>move(delta)</i>
<ul>
    <li>Handles character movement:
        <ul>
            <li>Reads keyboard input</li>
            <li>Calculates velocity (with 150x multiplier for physics scaling)</li>
            <li>Determines state (walk/idle) and direction</li>
            <li>Automatically flips sprite for left movement</li>
        </ul>
    </li>
</ul>

<i>dead()</i>
<ul>
    <li>Activates death state:
        <ul>
            <li>Sets die = true</li>
            <li>Changes condition to dead</li>
        </ul>
    </li>
</ul>

<i>anim()</i>
<ul>
    <li>Plays animation using pattern: {condition}_{direction}</li>
    <li>Examples: idle_down, walk_right, dead_up</li>
</ul>

<i>_on_player_animated_animation_finished()</i>
<ul>
    <li>Animation completion handler:
        <ul>
            <li>
                Transitions from dead to corpse state after death animation
            </li>
        </ul>
    </li>
</ul>


<h2>Implementation Details</h2>
<ol>
    <li>Automatic Sprite Flipping:
        <ul>
            <li>
                Horizontal movement uses single <i>walk_right</i> animation with automatic sprite flipping
            </li>
        </ul>
    </li>
    <li>Direction Priority:
        <ul>
            <li>
                Horizontal movement takes priority over vertical when determining animations
            </li>
        </ul>
    </li>
    <li>State System:
        <ul>
            <li>
                Smooth transitions between animations
            </li>
            <li>
                Death sequence: <i>dead</i> → (after animation) → <i>corpse</i>
            </li>
        </ul>
    </li>
    <li>Speed Calculation:
        <ul>
            <li>Final velocity uses 150x multiplier to match Godot's physics scaling</li>
        </ul>
    </li>
</ol>

<h2>Setup Instructions</h2>
<ol>
    <li>Attach script to CharacterBody2D node</li>
    <li>Add child AnimatedSprite2D node named "PlayerAnimated"</li>
    <li>Prepare animations named <i>{condition}_{direction}</i> (e.g., <i>idle_down</i>, <i>walk_up</i>)</li>
    <li>Adjust health and speed parameters in Inspector</li>
</ol>


## License

Free for personal and commercial use
