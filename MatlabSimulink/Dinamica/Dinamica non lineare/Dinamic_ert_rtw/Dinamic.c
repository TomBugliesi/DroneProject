/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Dinamic.c
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

#include "Dinamic.h"
#include "Dinamic_private.h"
#include "Dinamic_dt.h"

/* Block signals (default storage) */
B_Dinamic_T Dinamic_B;

/* Block states (default storage) */
DW_Dinamic_T Dinamic_DW;

/* Real-time model */
static RT_MODEL_Dinamic_T Dinamic_M_;
RT_MODEL_Dinamic_T *const Dinamic_M = &Dinamic_M_;

/* Model step function */
void Dinamic_step(void)
{
  real_T rtb_Gain_k;
  real_T rtb_Gain_l;
  real_T rtb_Saturation3;
  real_T u0;
  real_T u0_tmp;
  int16_T i;
  uint8_T output_raw[10];
  uint8_T status;

  /* MATLABSystem: '<Root>/I2C Read' */
  if (Dinamic_DW.obj.SampleTime != Dinamic_P.I2CRead_SampleTime) {
    Dinamic_DW.obj.SampleTime = Dinamic_P.I2CRead_SampleTime;
  }

  status = 0U;
  status = MW_I2C_MasterWrite(Dinamic_DW.obj.I2CDriverObj.MW_I2C_HANDLE, 8UL,
    &status, 1UL, true, false);
  if (0 == status) {
    MW_I2C_MasterRead(Dinamic_DW.obj.I2CDriverObj.MW_I2C_HANDLE, 8UL,
                      &output_raw[0], 10UL, false, true);
    memcpy((void *)&Dinamic_B.I2CRead[0], (void *)&output_raw[0], (uint16_T)
           ((size_t)10 * sizeof(uint8_T)));
  } else {
    /* MATLABSystem: '<Root>/I2C Read' */
    for (i = 0; i < 10; i++) {
      Dinamic_B.I2CRead[i] = 0U;
    }
  }

  /* End of MATLABSystem: '<Root>/I2C Read' */

  /* Sum: '<S6>/Add' incorporates:
   *  Constant: '<S6>/Constant'
   *  DataTypeConversion: '<S6>/Data Type Conversion'
   *  Gain: '<S6>/Gain'
   */
  rtb_Saturation3 = Dinamic_P.Gain_Gain * (real_T)Dinamic_B.I2CRead[4] +
    Dinamic_P.Constant_Value;

  /* Gain: '<S2>/Gain' incorporates:
   *  Constant: '<S2>/Constant'
   *  DataTypeConversion: '<S2>/Data Type Conversion'
   *  Sum: '<S2>/Subtract'
   */
  Dinamic_B.Gain = ((real_T)Dinamic_B.I2CRead[1] - Dinamic_P.Constant_Value_i) *
    Dinamic_P.Gain_Gain_a;

  /* Gain: '<S3>/Gain' incorporates:
   *  Constant: '<S3>/Constant'
   *  DataTypeConversion: '<S3>/Data Type Conversion'
   *  Sum: '<S3>/Subtract'
   */
  Dinamic_B.Gain_o = ((real_T)Dinamic_B.I2CRead[0] - Dinamic_P.Constant_Value_l)
    * Dinamic_P.Gain_Gain_p;

  /* Gain: '<S5>/Gain' incorporates:
   *  Constant: '<S5>/Constant'
   *  DataTypeConversion: '<S5>/Data Type Conversion'
   *  Sum: '<S5>/Subtract'
   */
  rtb_Gain_l = ((real_T)Dinamic_B.I2CRead[3] - Dinamic_P.Constant_Value_o) *
    Dinamic_P.Gain_Gain_j;

  /* Gain: '<S4>/Gain' incorporates:
   *  Constant: '<S4>/Constant'
   *  DataTypeConversion: '<S4>/Data Type Conversion'
   *  Sum: '<S4>/Subtract'
   */
  rtb_Gain_k = ((real_T)Dinamic_B.I2CRead[2] - Dinamic_P.Constant_Value_e) *
    Dinamic_P.Gain_Gain_jc;

  /* Sum: '<Root>/Add' incorporates:
   *  Sum: '<Root>/Add2'
   */
  u0_tmp = rtb_Saturation3 - Dinamic_B.Gain;
  u0 = ((u0_tmp + Dinamic_B.Gain_o) + rtb_Gain_l) + rtb_Gain_k;

  /* Saturate: '<Root>/Saturation' */
  if (u0 > Dinamic_P.Saturation_UpperSat) {
    u0 = Dinamic_P.Saturation_UpperSat;
  } else {
    if (u0 < Dinamic_P.Saturation_LowerSat) {
      u0 = Dinamic_P.Saturation_LowerSat;
    }
  }

  /* End of Saturate: '<Root>/Saturation' */

  /* Gain: '<Root>/Gain' incorporates:
   *  Constant: '<Root>/Constant'
   *  Sum: '<Root>/Subtract'
   */
  Dinamic_B.Gain_p = (u0 - Dinamic_P.Constant_Value_ol) * Dinamic_P.Gain_Gain_l;

  /* Sum: '<Root>/Add1' incorporates:
   *  Sum: '<Root>/Add3'
   */
  rtb_Saturation3 += Dinamic_B.Gain;
  u0 = ((rtb_Saturation3 + Dinamic_B.Gain_o) + rtb_Gain_l) - rtb_Gain_k;

  /* Saturate: '<Root>/Saturation1' */
  if (u0 > Dinamic_P.Saturation1_UpperSat) {
    u0 = Dinamic_P.Saturation1_UpperSat;
  } else {
    if (u0 < Dinamic_P.Saturation1_LowerSat) {
      u0 = Dinamic_P.Saturation1_LowerSat;
    }
  }

  /* End of Saturate: '<Root>/Saturation1' */

  /* Gain: '<Root>/Gain1' incorporates:
   *  Constant: '<Root>/Constant1'
   *  Sum: '<Root>/Subtract1'
   */
  Dinamic_B.Gain1 = (u0 - Dinamic_P.Constant1_Value) * Dinamic_P.Gain1_Gain;

  /* Sum: '<Root>/Add2' */
  u0 = ((u0_tmp - Dinamic_B.Gain_o) + rtb_Gain_l) - rtb_Gain_k;

  /* Saturate: '<Root>/Saturation2' */
  if (u0 > Dinamic_P.Saturation2_UpperSat) {
    u0 = Dinamic_P.Saturation2_UpperSat;
  } else {
    if (u0 < Dinamic_P.Saturation2_LowerSat) {
      u0 = Dinamic_P.Saturation2_LowerSat;
    }
  }

  /* End of Saturate: '<Root>/Saturation2' */

  /* Gain: '<Root>/Gain2' incorporates:
   *  Constant: '<Root>/Constant2'
   *  Sum: '<Root>/Subtract2'
   */
  Dinamic_B.Gain2 = (u0 - Dinamic_P.Constant2_Value) * Dinamic_P.Gain2_Gain;

  /* Sum: '<Root>/Add3' */
  rtb_Saturation3 = ((rtb_Saturation3 - Dinamic_B.Gain_o) + rtb_Gain_l) +
    rtb_Gain_k;

  /* Saturate: '<Root>/Saturation3' */
  if (rtb_Saturation3 > Dinamic_P.Saturation3_UpperSat) {
    rtb_Saturation3 = Dinamic_P.Saturation3_UpperSat;
  } else {
    if (rtb_Saturation3 < Dinamic_P.Saturation3_LowerSat) {
      rtb_Saturation3 = Dinamic_P.Saturation3_LowerSat;
    }
  }

  /* End of Saturate: '<Root>/Saturation3' */

  /* Gain: '<Root>/Gain3' incorporates:
   *  Constant: '<Root>/Constant3'
   *  Sum: '<Root>/Subtract3'
   */
  Dinamic_B.Gain3 = (rtb_Saturation3 - Dinamic_P.Constant3_Value) *
    Dinamic_P.Gain3_Gain;

  /* External mode */
  rtExtModeUploadCheckTrigger(1);

  {                                    /* Sample time: [0.002s, 0.0s] */
    rtExtModeUpload(0, (real_T)Dinamic_M->Timing.taskTime0);
  }

  /* signal main to stop simulation */
  {                                    /* Sample time: [0.002s, 0.0s] */
    if ((rtmGetTFinal(Dinamic_M)!=-1) &&
        !((rtmGetTFinal(Dinamic_M)-Dinamic_M->Timing.taskTime0) >
          Dinamic_M->Timing.taskTime0 * (DBL_EPSILON))) {
      rtmSetErrorStatus(Dinamic_M, "Simulation finished");
    }

    if (rtmGetStopRequested(Dinamic_M)) {
      rtmSetErrorStatus(Dinamic_M, "Simulation finished");
    }
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   */
  Dinamic_M->Timing.taskTime0 =
    ((time_T)(++Dinamic_M->Timing.clockTick0)) * Dinamic_M->Timing.stepSize0;
}

/* Model initialize function */
void Dinamic_initialize(void)
{
  /* Registration code */
  rtmSetTFinal(Dinamic_M, -1);
  Dinamic_M->Timing.stepSize0 = 0.002;

  /* External mode info */
  Dinamic_M->Sizes.checksums[0] = (478563378U);
  Dinamic_M->Sizes.checksums[1] = (1369623652U);
  Dinamic_M->Sizes.checksums[2] = (1940623542U);
  Dinamic_M->Sizes.checksums[3] = (1380098456U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    Dinamic_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(Dinamic_M->extModeInfo,
      &Dinamic_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(Dinamic_M->extModeInfo, Dinamic_M->Sizes.checksums);
    rteiSetTPtr(Dinamic_M->extModeInfo, rtmGetTPtr(Dinamic_M));
  }

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    Dinamic_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 15;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  {
    uint32_T i2cname;
    codertarget_arduinobase_inter_T *obj;
    uint32_T varargin_1;

    /* Start for MATLABSystem: '<Root>/I2C Read' */
    Dinamic_DW.obj.matlabCodegenIsDeleted = true;
    obj = &Dinamic_DW.obj;
    Dinamic_DW.obj.DefaultMaximumBusSpeedInHz = 400000.0;
    Dinamic_DW.obj.isInitialized = 0L;
    Dinamic_DW.obj.SampleTime = -1.0;
    obj->I2CDriverObj.MW_I2C_HANDLE = NULL;
    Dinamic_DW.obj.matlabCodegenIsDeleted = false;
    Dinamic_DW.obj.SampleTime = Dinamic_P.I2CRead_SampleTime;
    obj = &Dinamic_DW.obj;
    Dinamic_DW.obj.isSetupComplete = false;
    Dinamic_DW.obj.isInitialized = 1L;
    i2cname = 0;
    obj->I2CDriverObj.MW_I2C_HANDLE = MW_I2C_Open(i2cname, 0);
    Dinamic_DW.obj.BusSpeed = 100000UL;
    varargin_1 = Dinamic_DW.obj.BusSpeed;
    MW_I2C_SetBusSpeed(obj->I2CDriverObj.MW_I2C_HANDLE, varargin_1);
    Dinamic_DW.obj.isSetupComplete = true;
  }
}

/* Model terminate function */
void Dinamic_terminate(void)
{
  codertarget_arduinobase_inter_T *obj;

  /* Terminate for MATLABSystem: '<Root>/I2C Read' */
  obj = &Dinamic_DW.obj;
  if (!Dinamic_DW.obj.matlabCodegenIsDeleted) {
    Dinamic_DW.obj.matlabCodegenIsDeleted = true;
    if ((Dinamic_DW.obj.isInitialized == 1L) && Dinamic_DW.obj.isSetupComplete)
    {
      MW_I2C_Close(obj->I2CDriverObj.MW_I2C_HANDLE);
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/I2C Read' */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
