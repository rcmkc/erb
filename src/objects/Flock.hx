package objects;

import com.haxepunk.Entity;
import openfl.geom.Point;
import com.haxepunk.HXP;

/**
 * ...
 * @author Romko Pidstryhach

 */
class Flock
{
	private var _agents : Array<Enemy>;
	private var _target : Player;
	
	@:isVar public var alignmentWeight : Float;
	
	public function new(agents : Array<Enemy> = null) 
	{
		//_agents = [leader];
		//_agents.concat(agents);
		
		if (agents == null) 
			_agents = [];
		else
			_agents = agents;
	}
	
	public function addAgent(agent : Enemy)
	{
		_agents.push(agent);
	}
	
	public function setTarget(target : Player)
	{
		_target = target;
	}
	
	public function update()
	{
		for (agent in _agents) 
		{
			var alignment  : Point  = computeAlignment(agent);
			var cohesion   : Point  = computeCohesion(agent);
			var separation : Point  = computeSeparation(agent); 
			var border     : Point  = computeBorderAvoidance(agent); 
			
			agent.speed.x += 0.1*alignment.x + cohesion.x + 0.1*separation.x + 0.001*border.x;
			agent.speed.y += 0.1*alignment.y + cohesion.y + 0.1*separation.y + 0.001*border.y;
			
			var speed : Float = 5.0;
			
			if (_target != null) 
			{
				if (!_target.invisible) 
				{
					speed = 7.0;
				}
				else
				{
					speed = 5.0;
				}
			}
			
			agent.speed.normalize(speed);
		}
	}
	
	private function computeAlignment(leader : Enemy) : Point
	{
		var v : Point = new Point();
		
		var neighborCount : Int = 0;
		
		for (agent in _agents)
		{
			if (agent != leader)
			{
				if (HXP.distance(agent.x, agent.y, leader.x, leader.y) < G.FlockDistance)
				{
					v.x += agent.speed.x;
					v.y += agent.speed.y;
					
					neighborCount++;
				}
			}
		}
		
		if (neighborCount == 0)
			return v;
			
		v.x /= neighborCount;
		v.y /= neighborCount;
		
		v.normalize(1);

		return v;
	}
	
	private function computeCohesion(leader : Enemy) : Point
	{
		var v : Point = new Point();
		var neighborCount : Int = 0;
		
		for (agent in _agents) 
		{
			if (agent != leader)
			{
				if (HXP.distance(agent.x, agent.y, leader.x, leader.y) < G.FlockDistance)
				{
					v.x += agent.x;
					v.y += agent.y;
					
					neighborCount++;
				}
			}
		}
	
		if (neighborCount == 0)
			return v;
	
		v.x /= neighborCount;
		v.y /= neighborCount;
		
		if (_target != null) 
		{
			if (!_target.invisible) 
			{
				v.x = _target.x;
				v.y = _target.y;
			}
		}
		
		v = new Point(v.x - leader.x, v.y - leader.y);
		
		v.normalize(1);
		
		return v;
	}
	
	private function computeSeparation(leader : Enemy) : Point
	{
		var v : Point = new Point();
		var neighborCount : Int = 0;
		
		for (agent in _agents) 
		{
			if (agent != leader)
			{
				if (HXP.distance(agent.x, agent.y, leader.x, leader.y) < G.FlockDistance)
				{
					v.x += agent.x - leader.x;
					v.y += agent.y - leader.y;
					
					neighborCount++;
				}
			}
		}
	
		if (neighborCount == 0)
			return v;
		
		v.x /= neighborCount;
		v.y /= neighborCount;
		
		v.x *= -1;
		v.y *= -1;
		
		v.normalize(1);
		
		return v;
	}
	
	public function computeBorderAvoidance(leader : Enemy) : Point 
	{
		var v : Point = new Point();
		
		if (leader.left < -G.MaxRadius * 0.5)
		{
			v.x = G.ChaserSpeed;
		}
		
		if (leader.right > G.MaxRadius * 0.5)
		{
			v.x = -G.ChaserSpeed;
		}
		
		if (leader.top < -G.MaxRadius * 0.5)
		{
			v.y = G.ChaserSpeed;
		}
		
		if (leader.bottom > G.MaxRadius * 0.5)
		{
			v.y = -G.ChaserSpeed;
		}
		
		return v;
	}
}