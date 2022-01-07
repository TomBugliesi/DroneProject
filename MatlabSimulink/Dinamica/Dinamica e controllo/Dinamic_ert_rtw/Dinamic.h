/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Dinamic.h
 *
 * Code generated for Simulink model 'Dinamic'.
 *
 * Model version                  : 1.4
 * Simulink Coder version         : 9.4 (R2020b) 29-Jul-2020
 * C/C++ source code generated on : Wed Dec 22 18:07:37 2021
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Atmel->AVR
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Dinamic_h_
#define RTW_HEADER_Dinamic_h_
#include <string.h>
#include <float.h>
#include <stddef.h>
#ifndef Dinamic_COMMON_INCLUDES_
#define Dinamic_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_extmode.h"
#include "sysran_types.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "dt_info.h"
#include "ext_work.h"
#include "MW_I2C.h"
#endif                                 /* Dinamic_COMMON_INCLUDES_ */

#include "Dinamic_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "MW_target_hardware_resources.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWExtModeInfo
#define rtmGetRTWExtModeInfo(rtm)      ((rtm)->extModeInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

/* Block signals (default storage) */
typedef struct {
  real_T Gain;                         /* '<S2>/Gain' */
  real_T Gain_o;                       /* '<S3>/Gain' */
  real_T Gain_p;                       /* '<Root>/Gain' */
  real_T Gain1;                        /* '<Root>/Gain1' */
  real_T Gain2;                        /* '<Root>/Gain2' */
  real_T Gain3;                        /* '<Root>/Gain3' */
  uint8_T I2CRead[10];                 /* '<Root>/I2C Read' */
} B_Dinamic_T;

/* Block states (default storage) for system '<Root>' */
typedef struct {
  codertarget_arduinobase_inter_T obj; /* '<Root>/I2C Read' */
  struct {
    void *LoggedData;
  } Scope4_PWORK;                      /* '<Root>/Scope4' */
} DW_Dinamic_T;

/* Parameters (default storage) */
struct P_Dinamic_T_ {
  real_T I2CRead_SampleTime;           /* Expression: 1/500
                                        * Referenced by: '<Root>/I2C Read'
                                        */
  real_T Gain_Gain;                    /* Expression: 60/255
                                        * Referenced by: '<S6>/Gain'
                                        */
  real_T Constant_Value;               /* Expression: 80
                                        * Referenced by: '<S6>/Constant'
                                        */
  real_T Constant_Value_i;             /* Expression: 132
                                        * Referenced by: '<S2>/Constant'
                                        */
  real_T Gain_Gain_a;                  /* Expression: 10/150
                                        * Referenced by: '<S2>/Gain'
                                        */
  real_T Constant_Value_l;             /* Expression: 132
                                        * Referenced by: '<S3>/Constant'
                                        */
  real_T Gain_Gain_p;                  /* Expression: 10/150
                                        * Referenced by: '<S3>/Gain'
                                        */
  real_T Constant_Value_o;             /* Expression: 124
                                        * Referenced by: '<S5>/Constant'
                                        */
  real_T Gain_Gain_j;                  /* Expression: -15/150
                                        * Referenced by: '<S5>/Gain'
                                        */
  real_T Constant_Value_e;             /* Expression: 124
                                        * Referenced by: '<S4>/Constant'
                                        */
  real_T Gain_Gain_jc;                 /* Expression: 15/150
                                        * Referenced by: '<S4>/Gain'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 140
                                        * Referenced by: '<Root>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: 90
                                        * Referenced by: '<Root>/Saturation'
                                        */
  real_T Constant_Value_ol;            /* Expression: 90
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T Gain_Gain_l;                  /* Expression: 20
                                        * Referenced by: '<Root>/Gain'
                                        */
  real_T Saturation1_UpperSat;         /* Expression: 140
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T Saturation1_LowerSat;         /* Expression: 90
                                        * Referenced by: '<Root>/Saturation1'
                                        */
  real_T Constant1_Value;              /* Expression: 90
                                        * Referenced by: '<Root>/Constant1'
                                        */
  real_T Gain1_Gain;                   /* Expression: 20
                                        * Referenced by: '<Root>/Gain1'
                                        */
  real_T Saturation2_UpperSat;         /* Expression: 140
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T Saturation2_LowerSat;         /* Expression: 90
                                        * Referenced by: '<Root>/Saturation2'
                                        */
  real_T Constant2_Value;              /* Expression: 90
                                        * Referenced by: '<Root>/Constant2'
                                        */
  real_T Gain2_Gain;                   /* Expression: 20
                                        * Referenced by: '<Root>/Gain2'
                                        */
  real_T Saturation3_UpperSat;         /* Expression: 140
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  real_T Saturation3_LowerSat;         /* Expression: 90
                                        * Referenced by: '<Root>/Saturation3'
                                        */
  real_T Constant3_Value;              /* Expression: 90
                                        * Referenced by: '<Root>/Constant3'
                                        */
  real_T Gain3_Gain;                   /* Expression: 20
                                        * Referenced by: '<Root>/Gain3'
                                        */
};

/* Real-time Model Data Structure */
struct tag_RTM_Dinamic_T {
  const char_T *errorStatus;
  RTWExtModeInfo *extModeInfo;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T checksums[4];
  } Sizes;

  /*
   * SpecialInfo:
   * The following substructure contains special information
   * related to other components that are dependent on RTW.
   */
  struct {
    const void *mappingInfo;
  } SpecialInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block parameters (default storage) */
extern P_Dinamic_T Dinamic_P;

/* Block signals (default storage) */
extern B_Dinamic_T Dinamic_B;

/* Block states (default storage) */
extern DW_Dinamic_T Dinamic_DW;

/* Model entry point functions */
extern void Dinamic_initialize(void);
extern void Dinamic_step(void);
extern void Dinamic_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Dinamic_T *const Dinamic_M;
extern volatile boolean_T stopRequested;
extern volatile boolean_T runModel;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'Dinamic'
 * '<S1>'   : 'Dinamic/Rc_Controller'
 * '<S2>'   : 'Dinamic/Rc_Controller/J1X'
 * '<S3>'   : 'Dinamic/Rc_Controller/J1Y'
 * '<S4>'   : 'Dinamic/Rc_Controller/J2X'
 * '<S5>'   : 'Dinamic/Rc_Controller/J2Y'
 * '<S6>'   : 'Dinamic/Rc_Controller/p2'
 */
#endif                                 /* RTW_HEADER_Dinamic_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
