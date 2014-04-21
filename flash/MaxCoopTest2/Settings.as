package {

    import flash.geom.Rectangle;

    public final class Settings {
	public static const GAME_BOUNDARY:Rectangle = new Rectangle(0,0,WIDTH,HEIGHT);
	public static const HEIGHT:uint = 768;
	public static const WIDTH:uint = 1024;

	public static const BOUNDARY_WARP:String = "boundary_warp";
	public static const BOUNDARY_WARP_SMOOTH:String = "boundary_warp_smooth";
	public static const BOUNDARY_WARP_SMOOTH_RANDOM:String = "boundary_warp_smooth_random";
	public static const BOUNDARY_STOP:String = "boundary_stop";

	public static const GRAVITY:Number = 1.5;
	public static const PLAYER_ACCEL:Number = 1.5;
	public static const PLAYER_JUMPVEL:Number = -24;
	public static const PLAYER_FRICTION_X:Number = 0.8;
	public static const PLAYER_FRICTION_Y:Number = 0.99;
	public static const PLAYER_JUMP_ONGROUND:String = "player_jump_onground";
	public static const PLAYER_JUMP_INAIR:String = "player_jump_inair";
	public static const PLAYER_FACING_RIGHT:String = "player_facing_right";
	public static const PLAYER_FACING_LEFT:String = "player_facing_left";
	public static const PLAYER_FACING_UP:String = "player_facing_up";
    }
}
