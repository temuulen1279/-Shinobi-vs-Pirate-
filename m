# -Shinobi-vs-Pirate- <!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Shinobi vs Pirate</title>
  <style>
    body { margin: 0; background: black; overflow: hidden; }
    canvas {
      display: block;
      margin: auto;
      background: linear-gradient(#222, #000);
      border: 2px solid white;
    }
    #info {
      text-align: center;
      color: white;
      font-family: sans-serif;
      margin-top: 10px;
    }
  </style>
</head>
<body>
<canvas id="gameCanvas" width="800" height="400"></canvas>
<div id="info">RAITO: A/D to move, Z to attack | LENO: ←/→ to move, X to attack</div>

<script>
const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

let raito = { x: 100, y: 300, color: 'orange', health: 100 };
let leno = { x: 600, y: 300, color: 'red', health: 100 };

function drawFighter(fighter) {
  ctx.fillStyle = fighter.color;
  ctx.fillRect(fighter.x, fighter.y, 40, 80);
}

function drawHealthBars() {
  ctx.fillStyle = 'green';
  ctx.fillRect(50, 50, raito.health * 2, 20);
  ctx.fillRect(550, 50, leno.health * 2, 20);
  ctx.strokeStyle = 'white';
  ctx.strokeRect(50, 50, 200, 20);
  ctx.strokeRect(550, 50, 200, 20);
}

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  drawFighter(raito);
  drawFighter(leno);
  drawHealthBars();

  if (raito.health <= 0 || leno.health <= 0) {
    ctx.fillStyle = "white";
    ctx.font = "40px sans-serif";
    const winner = raito.health > 0 ? "RAITO WINS!" : "LENO WINS!";
    ctx.fillText(winner, 300, 200);
  }
}

function attack(attacker, target) {
  if (Math.abs(attacker.x - target.x) < 60) {
    target.health -= 10;
    if (target.health < 0) target.health = 0;
  }
}

document.addEventListener("keydown", function(e) {
  if (raito.health <= 0 || leno.health <= 0) return;

  switch(e.key) {
    case "ArrowRight": leno.x += 10; break;
    case "ArrowLeft": leno.x -= 10; break;
    case "d": raito.x += 10; break;
    case "a": raito.x -= 10; break;
    case "z": attack(raito, leno); break;
    case "x": attack(leno, raito); break;
  }
});

function gameLoop() {
  draw();
  requestAnimationFrame(gameLoop);
}
gameLoop();
</script>
</body>
</html>
