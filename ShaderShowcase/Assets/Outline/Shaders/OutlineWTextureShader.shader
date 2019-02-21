﻿Shader "OutlineShaders/OutlineWTexture"
{
	Properties
	{
		_MainTex("Our 2D texture", 2D) = "white" {}
		_OutlineColor("Our outlines Color", Color) = (0, 1, 0, 1)
		_OutlineWidth("Our outlines width", Range(.002, 2)) = 0.005
	}
		
	SubShader
	{
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

		Pass
		{
			Cull Front
		
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct appdata
				{
					float4 vertex: POSITION;
					float3 normal: NORMAL;
				};

				struct v2f
				{
					float4 pos : SV_POSITION;
					fixed4 color :COLOR;
				};
				float _OutlineWidth;
				float4 _OutlineColor;

				v2f vert(appdata v)
				{
					v2f o;
					o.pos = UnityObjectToClipPos(v.vertex);
					float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
					float2 offset = TransformViewToProjection(norm.xy);

					o.pos.xy += offset * o.pos.z * _OutlineWidth;
					o.color = _OutlineColor;
					return o;
				}
				fixed4 frag(v2f i) : SV_Target
				{
					return i.color;
				}

			ENDCG
		}
	}
}