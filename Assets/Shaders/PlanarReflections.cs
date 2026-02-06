using UnityEngine;

[ExecuteAlways]
public class PlanarReflections : MonoBehaviour
{
    [Header("References")]
    [SerializeField] private GameObject waterSurface;

    private void Update()
    {
        Transform cam = Camera.main.transform;

        // position
        float newY = waterSurface.transform.position.y * 2 - cam.position.y;
        transform.position = new Vector3(cam.position.x, newY, cam.position.x);

        // angle
        transform.rotation = Quaternion.Euler(transform.eulerAngles.x, transform.eulerAngles.y, 0);
    }
}
