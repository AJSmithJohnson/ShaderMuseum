Shader "MultiPass/MultiPassOutline"
{
	Properties
	{
		_MainTex("Our 2D texture", 2D) = "white" {}
		_OutlineColor("Outline Color", Color) = (1, 1, 1, 1)
		_OutlineWidth("The Outline Width", Range(.002, 1)) = 0.005
	}
		
	SubShader
	{
		Tags{"Queue" = "Transparent"}
		ZWrite off
		CGPROGRAM
			#pragma surface surf Lambert vertex:vert

			struct Input
			{
				float2 uv_MainTex;
			};

			float _OutlineWidth;
			float4 _OutlineColor;
			sampler2D _MainTex;
			void vert(inout appdata_full v)
			{
				v.vertex.xyz += v.normal *_OutlineWidth;
			}

			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Emission = _OutlineColor;
			}

		ENDCG

		ZWrite on
		CGPROGRAM
			#pragma surface surf Lambert
			struct Input
			{
				float2 uv_MainTex;
			};

			sampler2D _MainTex;
			void surf(Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			}

		ENDCG
	}
	Fallback "Diffuse"
}