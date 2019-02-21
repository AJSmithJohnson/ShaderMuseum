Shader "VertexManipulation/Wave"
{
	Properties
	{
		_MainTex("Our 2D texture", 2D) = "white" {}
		_Tint("Color Tint", Color) = (1,1,1,1)
		_Freq("Frequency", Range(0,5)) = 3
		_Speed("Speed of wave", Range(0, 100)) = 10
		_Amplitude("Amplitude of wave", Range(0, 1)) = .5
	}
	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert vertex:vert


		sampler2D _MainTex;
		float4 _Tint;
		float _Freq;
		float _Speed;
		float _Amplitude;

		struct Input
		{
			float2 uv_MainTex;
			float3 vertColor;
		};
		


		struct appdata
		{
			float4 vertex: POSITION;
			float3 normal: NORMAL;
			float4 texcoord: TEXCOORD0;
			
		};


		void vert(inout appdata v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float t = _Time * _Speed;
			float waveHeight = sin(t+v.vertex.x * _Freq) * _Amplitude + sin(t*2 + v.vertex.x * _Freq*2) * _Amplitude;
			v.vertex.y = v.vertex.y + waveHeight;
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
			o.vertColor = waveHeight + 2;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			float4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c *_Tint.rgb * IN.vertColor.rgb;
		}
		

		ENDCG
	}
	Fallback "Diffuse"
}