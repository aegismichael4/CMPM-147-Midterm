using UnityEngine;

public class WaterSurface : MonoBehaviour
{
    private float startHeight;
    [SerializeField] private float waveSpeed;
    [SerializeField] private float waveAmplitude;

    private void Start()
    {
        startHeight = transform.position.y;
    }

    private void OnDisable()
    {
        transform.position = new Vector3(transform.position.x, startHeight, transform.position.z);
    }

    private void Update()
    {
        float newY = startHeight + Mathf.Sin(Time.time * waveSpeed) * waveAmplitude;
        transform.position = new Vector3(transform.position.x, newY, transform.position.z);

    }
}
