Shader "MyClipShaders/FourthClip"
{
	Properties
	{
		_foreGroundColor("My foreGround Color", Color) = (1,1,1,1)
		_backGroundColor("My foreGround Color", Color) = (1,1,1,1)
		_foreGroundMask("My texture mask", 2D) = "white" {}
		_foreGroundCutoff("ForeGroundCutoff", Range(0, 1)) = 0
		_backGroundCutoff("ForeGroundCutoff", Range(0, 1)) = 0
		
	}

		SubShader
		{
			Tags {"RenderType" = "Opaque"}
			LOD 300
			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows
			#pragma target 4.6

			sampler2D _foreGroundMask;
			float4 _foreGroundColor;
			float4 _backGroundColor;
			float _foreGroundCutoff;
			float _backGroundCutoff;
			struct Input
			{
			float2 uv_foreGroundMask;
			};

			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				fixed x = (-0.5 + IN.uv_foreGroundMask.x) * 2;
				fixed y = (-0.5 + IN.uv_foreGroundMask.y) * 2;
				//fixed radius =  sqrt(x*x + y*y);
				fixed radius = 0.5 + sin(x*_Time) * 0.5;
				clip(1-radius - _backGroundCutoff);
				o.Albedo = _backGroundColor;
				if (radius > _foreGroundCutoff)
				{
					o.Albedo = _foreGroundColor;
				}

				//o.Alpha = c.a;
			}

			ENDCG
		}
}