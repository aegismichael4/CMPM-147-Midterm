# Underwater Scene Tool

This project contains a small collection of proceedural shaders to provide a customizable, 3D underwater scene.

## Setup

- To use, clone the repo and open with Unity.
- **Unity Version:** 6000.3.3f1

## Components

 - **Water Light Shader:** This shader uses scrolling noise to provide the visual effect of light shining down through water onto the ocean floor. It can be configured to look like the surface of a liquid if desired though!
 - **Volumetric Water Shader:** This post processing shader models the look of light dissapearing into darkness underwater, and provides some nice godrays for the scene. I did not write it, it came from [Technically Harry's Tutorial](https://www.youtube.com/watch?v=8P338C9vYEE) on YouTube!!

## Parameters

### Water Light Shader (Material called "LightMarbling" in-engine):
| Parameter | Description |
| --------- | ----------- |
| Marbling Color | The color of the light on the ground |
| Marbling Speed | The speed that the Voronoi cells jiggle |
| Marbling Distortion | The strength of the UV distortion on the Voronoi cells |
| Wall Climb Height | The height that the shader will climb up walls (from it's lowest y coordinate) |
| Start Fade Out Distance | The distance from the camera that the shader will start to fade out |
| Max Draw Distance | The distance from the camera that the shader will be completely faded out |
| Tile Size | The size of each Voronoi Cell |
| Scroll Speed | The speed that the shader will scroll on the x and z axis |

### Volumetric Water Shader (Material called "VolumetricWater" in-engine):
| Parameter | Description |
| --------- | ----------- |
| Color | The color of the fog |
| Light Contribution | What color the fog picks up when lit by the main light of the scene |
| Density Multiplier | How dense the fog is |
| Light Scattering | Heyney-Greenstein light scattering (I don't know either) |
| Min Distance | The closest to the camera it will start raymarching (probably should be 0) |
| Max Distance | The furthest from the camera to raymarch |
| Step Size | How far each ray will move between steps |
| Noise Offset | How much to offset the ray's start position based on blue noise (ideally equal to Step Size) |

### Water Surface Shader (Material called "WaterSurface" in-engine):
| Parameter | Description |
| --------- | ----------- |
| Water Color | The color of the water itself |
| Reflection Alpha | The opacity of the planar reflections |
| Warble Intensity | The intensity of the reflection displacement (appearance of waves) |
| Warble Speed | The speed of the reflection displacement |

### Other Things I Adjust to Make Cool Scenes
- The base material color of the ground (called "Sand" in-engine)
- The Directional Light GameObject
- The Global Volume post-processing effects
- The Water Surface GameObject has parameters for how much the water surface bobs up and down
