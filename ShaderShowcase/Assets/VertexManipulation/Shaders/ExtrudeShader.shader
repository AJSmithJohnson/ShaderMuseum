Shader "VertexManipulation/Extrude"
{
	Properties
	{
		_MainTex("Our Texture", 2D) = "white" {}
		_ExtrudeAmount("Extrusion Amount", Range(-5, 5)) = 0.01
	}

	SubShader
		{
			CGPROGRAM
				#pragma surface surf Lambert vertex:vert
			
				struct Input
				{
					float2 uv_MainTex;
				};

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
				};

				float _ExtrudeAmount;
				sampler2D _MainTex;
				
				void vert(inout appdata v)
				{
					v.vertex.xyz += v.normal * _ExtrudeAmount;
				}
			
				void surf(Input IN, inout SurfaceOutput o)
				{
					o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
				}


			ENDCG
		}
		Fallback "Diffuse"
}