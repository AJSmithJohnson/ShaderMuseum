Shader "If_And_Or_Shaders/StripedDiffuseShader"
{
	Properties
	{
		_myColor("Color", Color) = (1,1,1,1)
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_rimPower("Rim power", Range(0, 8.0)) = 2.0
		_stripSize("Stripe size", Range(0, 1)) = .2

	}

	SubShader
	{
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float2 uv_myDiffuse;
				float3 viewDir;
				float3 worldPos;
			};

			fixed4 _myColor;
			sampler2D _myDiffuse;
			float _rimPower;
			float _stripSize;


			void surf(Input IN, inout SurfaceOutput o)
			{
				half rim = 1-saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = frac(IN.worldPos.y *10 * _stripSize) > _stripSize -0.1 ? tex2D(_myDiffuse, IN.uv_myDiffuse) * rim : _myColor * rim;
			}

			
		ENDCG
	}
}