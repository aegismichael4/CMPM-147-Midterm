Shader "Custom/WaterSurface"
{
    HLSLINCLUDE

        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

        TEXTURE2D(_MainTex);
        SAMPLER(sampler_MainTex);

        TEXTURE2D(_CameraGBufferTexture2); // WS Normals
        SAMPLER(sampler_CameraGBufferTexture2);

        TEXTURE2D(_CameraGBufferTexture1); // Specular color (RGB), Smoothness(A)
        SAMPLER(sampler_CameraGBufferTexture1);

        TEXTURE2D(_CameraDepthTexture);
        SAMPLER(sampler_CameraDepthTexture);

        float4x4 _InverseView;

        struct v2f
        {
            float uv : TEXCOORD0;
            float4 vertex : SV_POSITION;
            float3 ray : TEXCOORD1;
        };

        // Z buffer to linear 0..1 depth
        inline float Linear01Depth( float z )
        {
            return 1.0 / (_ZBufferParams.x * z + _ZBufferParams.y);
        }

        float3 ComputeViewSpacePosition(float3 ray, float2 uv)
        {
            // render settings
            float near = _ProjectionParams.y;
            float far = _ProjectionParams.z;

            //z buffer sample
            float z = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, sampler_CameraDepthTexture, uv);

            // far plane exclusion
            #if !defined(EXCLUDED_FAR_PLANE)
                float mask = 1;
            #elif defined(UNITY_REVERSED_Z)
                float mask = z > 0;
            #else
                float mask = z < 1;
            #endif

            float3 vposPers = ray * Linear01Depth(z);

            return vposPers * mask;
        }

        float3 ScreenToWorldPos(float3 ray, float2 uv) {
            return mul(_InverseView, float4(ComputeViewSpacePosition(ray, uv), 1.0)).xyz;
        }

        v2f vert(uint vertexID : SV_VertexID)
        {
            float far = _ProjectionParams.z;
            float x = (vertexID != 1) ? -1 : 3;
            float y = (vertexID == 2) ? -3 : 1;
            float3 vpos = float3(x, y, 1.0);

            float3 rayPers = mul(unity_CameraInvProjection, vpos.xyzz * far).xyz;

            v2f o;
            o.vertex = float4(vpos.x, -vpos.y, 1, 1);
            o.uv = (vpos.xy + 1) / 2;
            o.ray = rayPers;
            return o;
        }

        float4 Frag(v2f i) : SV_TARGET
        {
            float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.uv);
            float3 worldPos = ScreenToWorldPos(i.ray, i.uv);
            color.rgb = worldPos;
            //color = SAMPLE_TEXTURE2D(_CameraGBufferTexture2, sampler_CameraGBufferTexture2, i.uv) * 2.0 - 1.0;
            return color;
        }

    ENDHLSL

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM

                #pragma vertex vert
                #pragma fragment Frag

            ENDHLSL
        }
    }
}
