Shader "MyClipShaders/OtherClipShader"
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
			fixed4 c = tex2D(_foreGroundMask, IN.uv_foreGroundMask);
			clip(c.r - _backGroundCutoff);
			o.Albedo = _backGroundColor;
			if (c.r > _foreGroundCutoff)
			{
				o.Albedo = _foreGroundColor;
			}
			
			o.Alpha = c.a;
		}

		ENDCG
	}
}