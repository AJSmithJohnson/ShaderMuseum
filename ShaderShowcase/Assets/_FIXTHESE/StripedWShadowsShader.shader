Shader "If_And_Or_Shaders/StripedWShadowsShader"
{
	Properties
	{
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_BaseColor("Our base Color", Color) = (1,1,1,1)
		
	}
	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input
		{
			float3 viewDir;
			float3 worldPos;
		};

		float4 _RimColor;
		fixed4 _BaseColor;

		void surf(Input IN, inout SurfaceOutput o)
		{
			half rim = 1.0- saturate(dot(normalize(IN.viewDir), o.Normal));

			o.Emission = frac(IN.worldPos.y*10 * 0.5) > 0.4 ? _RimColor * rim : _BaseColor * rim;
		}


		ENDCG
	}

}