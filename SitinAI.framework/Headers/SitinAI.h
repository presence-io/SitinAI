//
// Created by apple on 2024/4/19.
//

#ifndef SITINAI_H
#define SITINAI_H

#if __WIN32__
    #ifdef BUILDING_DLL
        #define DLLEXPORT __declspec(dllexport)
    #else
        #define DLLEXPORT __declspec(dllimport)
    #endif
#else
    #define DLLEXPORT 
#endif    

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef unsigned char uchar;

DLLEXPORT void Sitin_ai_engine_init();

DLLEXPORT void* Sitin_segmentation_start();
struct SegmentResult {
    uchar* buffer;
    int32_t width;
    int32_t height;
    int32_t channels;
    int32_t depth;
};
DLLEXPORT struct SegmentResult Sitin_ai_segmentation_process(uchar* buffer, int32_t width, int32_t height, int32_t channels);
DLLEXPORT void Sitin_ai_segmentation_shutdown();

DLLEXPORT void* Sitin_face_detection_start();

typedef struct BoundingBox2d {
    float x;
    float y;
    float width;
    float height;
} BoundingBox2d;

typedef struct Landmark2d {
    float x;
    float y;
} Landmark2d;

typedef struct FaceDetectionResult {
    int32_t nFaces;
    BoundingBox2d bbox;
    int32_t nLandmarks;
    Landmark2d* landmarks;
} DetectionResult;
DLLEXPORT struct FaceDetectionResult Sitin_ai_face_detection_process(uchar* buffer, int32_t width, int32_t height, int32_t channels);
DLLEXPORT void Sintin_ai_face_detection_shutdown();

char* Sitin_ai_engine_get_resources_path();

#ifdef __cplusplus
}
#endif

#endif //SITINAI_H
