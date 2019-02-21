Shader "DotProductShaders/RimLight"
{


	Properties
	{
		_rimColor("rimlight color", Color) = (1,1,1,1)
		_rimPower("rimlight power", Range(0.5, 5)) = 3.0

	}

	SubShader
	{	
		CGPROGRAM
			#pragma surface surf Lambert

			struct Input
			{
				float3 viewDir;
			};
			float4 _rimColor;
			float _rimPower;

			void surf(Input IN, inout SurfaceOutput o)
			{
				half rim = 1.0- saturate(dot(normalize(IN.viewDir), o.Normal));
				o.Emission = _rimColor * pow(rim, _rimPower);

			}

		ENDCG
	}
}