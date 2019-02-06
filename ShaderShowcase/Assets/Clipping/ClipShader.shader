Shader "MyClipShaders/ClipShader"
{
	Properties
	{
		_Color("My Color", Color) = (1,1,1,1)
		_MainTex("My Texture", 2D) = "white" {}
		_cutoff("Cutoff", Range(0, 1)) = 0
	}

		SubShader
	{
		Tags {"RenderType" = "Opaque"}
		LOD 300
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 4.6

		sampler2D _MainTex;
		float4 _Color;
		float _cutoff;
		struct Input
		{
		float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			clip(c.r - _cutoff);
			o.Albedo = _Color;
			o.Alpha = c.a;
		}

		ENDCG
	}
}