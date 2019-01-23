Shader "WaterShaders/TessellationWaves"
{
	Properties
	{
		_Color1("FirstColor", Color) = (1,1,1,1)
		_Color2("SecondColor", Color) = (1,1,1,1)
		_DispTex("A DisplacementTexture", 2D) = "grey" {}
		_DisplacementAmount("Displacement Intensity", Range(0, 100)) = 0.3
		_Tess("Tessellation Amount", Range(0, 100)) = 0.5
		_WaveHeight("Height of wave", Range(0, 20)) = 0.5
		_WaveLength("LEngth of wave", Range(0, 20)) = 0.5
		_CubeMap("CubeMapFor Reflections", CUBE) = "white"{}
		_WaveSpeed("Speed of wave", Range(0, 20)) = 0.5
	}

		SubShader
	{
		CGPROGRAM
		#pragma surface surf Standard addshadow vertex:vert tessellate:tess nolightmap  fullforwardshadows
		#include "Tessellation.cginc"
	

		fixed4 _Color1;
		fixed4 _Color2;
		sampler2D _DispTex;
		float _DisplacementAmount;
		float _Tess;
		float _WaveHeight;
		float _WaveLength;
		float _WaveSpeed;
		samplerCUBE _CubeMap;

		struct appdata
		{
			float4 vertex	: POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;
			float2 texcoord1: TEXCOORD1;
			float2 texcoord2 : TEXCOORD2;
		};

		float4 tess(appdata v0, appdata v1, appdata v2)
		{
			return UnityEdgeLengthBasedTess(v0.vertex, v1.vertex, v2.vertex, _Tess);
		}

		void vert(inout appdata v)
		{
			float displacement = tex2Dlod(_DispTex, float4(v.texcoord.xy, 0, 0).rgba * _DisplacementAmount);
			
			v.vertex.y = v.normal.y * displacement;
			float3 wave = v.vertex.xyz;
			float length = 2 * UNITY_PI / _WaveLength;
			wave.y = _WaveHeight * sin(length * (wave.x - _WaveSpeed * _Time.y ));
			v.vertex.xyz += wave;
		}

		struct Input
		{
			float2 uv_DispTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = _Color1.rgb;
		}

		ENDCG
	}


}