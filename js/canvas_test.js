/*
TODO
 - pass the branch num to a new-to-make node and insist it doesn't expand in the direction
   slot of this number (or whichever number it would be relative to it).
 - investigate properties of current branching number: which others than 6 work?
 - investigate math patterns for other branching structures. 
 */

function init() {
    //    "use strict";
    // These are global
    ctx = document.getElementById('canvas').getContext('2d');
    startX = screen.width / 2;
    startY = screen.height / 2;
    t = 0;
    delay = 50;
    branches = 3;
    r = 30;
    reach = 45;
    maxDepth = 5;
    // testing
    //drawNode(startX, startY, 0);

    setInterval(startDraw, 3000);

    // Interval in ms
    //setInterval(draw, 10);
}

function startDraw() {
    ctx.clearRect(0,0,screen.width,screen.height);
    drawNode(startX, startY, 0);
}

function drawNode(x, y, d) {
    //    "use strict";
    ctx.strokeStyle = "rgb(255, 255, 255)"
    ctx.beginPath();
    ctx.arc(x, y, r, 0, Math.PI * 2);
    ctx.stroke();
    window.setTimeout(function() { expandNode(x,y, d) }, delay);
}

function expandNode(x, y, d) {
    if (d > maxDepth) {
	return;
    }
    // can generalize for different node shapes
    // assumption: branches > 0
    var radiansPerBranch = (Math.PI * 2) / branches;
    var branchesToDraw = Math.floor(Math.random()*branches);
    writeNum(x, y, branchesToDraw);
    for (var i = 0; i < branchesToDraw; i++) {
	var ang = radiansPerBranch * i;
	var cosang = Math.cos(ang);
	var sinang = Math.sin(ang);
	// cx, cy coordinates on circumfrence
	var cx = (cosang * r) + x;
	var cy = (sinang * r) + y;
	// rx, ry are the reach coordinates
	var rx = (cosang * reach) + cx;
	var ry = (sinang * reach) + cy;
	// nx, ny are the coordinates of the center of the attaching circle
	var nx = (cosang * r) + rx;
	var ny = (sinang * r) + ry;
	window.setTimeout(function() { drawBranch(cx, cy, rx, ry) }, delay * i)
	window.setTimeout(function() { drawNode(nx, ny, d + 1) }, delay * i);
    }
}

// from x, from y, to x, to y
function drawBranch(fx, fy, tx, ty) {
    // draw
    ctx.beginPath();
    ctx.moveTo(fx, fy);
    ctx.lineTo(tx, ty);
    ctx.stroke();
}

function writeNum(x, y, num) {
    ctx.font = "12px Georgia";
    ctx.fillStyle = "white";
    ctx.fillText(num, x-2, y);
}

function draw() {
    //    "use strict";
    var ang = ((30 - x) / 30) * Math.PI;
    //ctx.clearRect(0,0,1680,1050);
    ctx.fillStyle = "rgba(255, 255, 255, 20)";
    ctx.fillRect(x, Math.sin(ang)*20 + x/2, 20, 20);
    t++;
}