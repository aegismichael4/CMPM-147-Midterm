using UnityEngine;
using UnityEditor;

[ExecuteAlways]
public class PlanarReflections : MonoBehaviour
{
    private Vector2 resolution;

    [Header("References")]
    [SerializeField] private GameObject waterSurface;
    private Camera reflectionCamera;
    [SerializeField] private RenderTexture reflectionRenderTexture;
    [SerializeField] private int reflectionResolution;

    private void Awake()
    {
        reflectionCamera = GetComponent<Camera>();
    }

    private void Update()
    {

        // access current camera
        Camera cam;
        if (Application.isPlaying)
        {
            cam = Camera.main; // regular game camera
            reflectionCamera.fieldOfView = cam.fieldOfView;
        }
        else
        {
            cam = SceneView.lastActiveSceneView.camera; // scene camera
        }
        if (cam == null) return;

        SetCameraTransform(cam);
        SetResolution(cam);
    }

    private void SetCameraTransform(Camera cam)
    {
        // position
        float newY = waterSurface.transform.position.y * 2 - cam.transform.position.y;
        transform.position = new Vector3(cam.transform.position.x, newY, cam.transform.position.z);

        // angle
        transform.rotation = Quaternion.Euler(-cam.transform.eulerAngles.x, cam.transform.eulerAngles.y, 0);
    }

    private void SetResolution(Camera cam)
    {
        resolution = new Vector2(cam.pixelWidth, cam.pixelHeight);

        reflectionRenderTexture.Release();
        reflectionRenderTexture.width = Mathf.RoundToInt(resolution.x) * reflectionResolution / Mathf.RoundToInt(resolution.y);
        reflectionRenderTexture.height = reflectionResolution;
    }
}
