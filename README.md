# Underwater Scene Tool

This project contains a small collection of proceedural shaders to provide a customizable, 3D underwater scene.

## Components

 - **Water Light Shader:** This shader uses scrolling noise to provide the visual effect of light shining down through water onto the ocean floor. It can be configured to look like the surface of a liquid if desired though!
 - **Volumetric Water Shader:** This post processing shader models the look of light dissapearing into darkness underwater, and provides some nice godrays for the scene. I did not write it, it came from [Technically Harry's Tutorial](https://www.youtube.com/watch?v=8P338C9vYEE) on YouTube!!

## Parameters

### Water Light Shader (Material called "LightMarbling" in-engine):
| Parameter | Description |
| --------- | ----------- |
| Light Color | The color of the light on the ground |
| Warbling Speed | The speed that the Voronoi cells jiggle |
| Marbling Distortion | The strength of the UV distortion on the Voronoi cells |
| Wall Climb Height | The height that the shader will climb up walls (from it's lowest y coordinate) |
| Start Fade | The distance from the camera that the shader will start to fade out |
| End Fade | The distance from the camera that the shader will be completely faded out |
| Tile Size | The size of each Voronoi Cell |
| Scroll Speed | The speed that the shader will scroll on the x and z axis |

### Volumetric Water Shader (Material called "VolumetricWater" in-engine):
| Parameter | Description |
| --------- | ----------- |
| Color | The color of the fog |
| Min Distance | The closest to the camera it will start raymarching (probably should be 0) |
| Max Distance | The furthest from the camera to raymarch |
| Step Size | How far each ray will move between steps |
| Density Multiplier | How dense the fog is |
| Noise Offset | How much to offset the ray's start position based on blue noise (ideally equal to Step Size) |
| Light Contribution | What color the fog picks up when lit by the main light of the scene |
| Light Scattering | Heyney-Greenstein light scattering (I don't know either) |

### Other Things I Adjust to Make Cool Scenes
- The base material color of the ground (called "Sand" in-engine)
- The Directional Light GameObject
- The Global Volume post-processing effects
