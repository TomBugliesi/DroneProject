/* Simscape target specific file.
 * This file is generated for the Simscape network associated with the solver block 'DinamicaNonLineare_Controllo/simscape/Solver Configuration'.
 */

#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
#include "sm_RuntimeDerivedValuesBundle.h"
#include "sm_CTarget.h"

void DinamicaNonLineare_Controllo_4531be4f_1_setTargets(const
  RuntimeDerivedValuesBundle *rtdv, CTarget *targets)
{
  (void) rtdv;
  (void) targets;
}

void DinamicaNonLineare_Controllo_4531be4f_1_resetAsmStateVector(const void
  *mech, double *state)
{
  double xx[1];
  (void) mech;
  xx[0] = 0.0;
  state[0] = xx[0];
  state[1] = xx[0];
  state[2] = xx[0];
  state[3] = xx[0];
  state[4] = xx[0];
  state[5] = xx[0];
}

void DinamicaNonLineare_Controllo_4531be4f_1_initializeTrackedAngleState(const
  void *mech, const RuntimeDerivedValuesBundle *rtdv, const int *modeVector,
  const double *motionData, double *state)
{
  const double *rtdvd = rtdv->mDoubles.mValues;
  const int *rtdvi = rtdv->mInts.mValues;
  (void) mech;
  (void) rtdvd;
  (void) rtdvi;
  (void) state;
  (void) modeVector;
  (void) motionData;
}

void DinamicaNonLineare_Controllo_4531be4f_1_computeDiscreteState(const void
  *mech, const RuntimeDerivedValuesBundle *rtdv, double *state)
{
  const double *rtdvd = rtdv->mDoubles.mValues;
  const int *rtdvi = rtdv->mInts.mValues;
  (void) mech;
  (void) rtdvd;
  (void) rtdvi;
  (void) state;
}

void DinamicaNonLineare_Controllo_4531be4f_1_adjustPosition(const void *mech,
  const double *dofDeltas, double *state)
{
  (void) mech;
  state[0] = state[0] + dofDeltas[0];
  state[1] = state[1] + dofDeltas[1];
  state[2] = state[2] + dofDeltas[2];
}

static void perturbAsmJointPrimitiveState_0_0(double mag, double *state)
{
  state[0] = state[0] + mag;
}

static void perturbAsmJointPrimitiveState_0_0v(double mag, double *state)
{
  state[0] = state[0] + mag;
  state[3] = state[3] - 0.875 * mag;
}

static void perturbAsmJointPrimitiveState_0_1(double mag, double *state)
{
  state[1] = state[1] + mag;
}

static void perturbAsmJointPrimitiveState_0_1v(double mag, double *state)
{
  state[1] = state[1] + mag;
  state[4] = state[4] - 0.875 * mag;
}

static void perturbAsmJointPrimitiveState_0_2(double mag, double *state)
{
  state[2] = state[2] + mag;
}

static void perturbAsmJointPrimitiveState_0_2v(double mag, double *state)
{
  state[2] = state[2] + mag;
  state[5] = state[5] - 0.875 * mag;
}

void DinamicaNonLineare_Controllo_4531be4f_1_perturbAsmJointPrimitiveState(const
  void *mech, size_t stageIdx, size_t primIdx, double mag, boolean_T
  doPerturbVelocity, double *state)
{
  (void) mech;
  (void) stageIdx;
  (void) primIdx;
  (void) mag;
  (void) doPerturbVelocity;
  (void) state;
  switch ((stageIdx * 6 + primIdx) * 2 + (doPerturbVelocity ? 1 : 0))
  {
   case 0:
    perturbAsmJointPrimitiveState_0_0(mag, state);
    break;

   case 1:
    perturbAsmJointPrimitiveState_0_0v(mag, state);
    break;

   case 2:
    perturbAsmJointPrimitiveState_0_1(mag, state);
    break;

   case 3:
    perturbAsmJointPrimitiveState_0_1v(mag, state);
    break;

   case 4:
    perturbAsmJointPrimitiveState_0_2(mag, state);
    break;

   case 5:
    perturbAsmJointPrimitiveState_0_2v(mag, state);
    break;
  }
}

void DinamicaNonLineare_Controllo_4531be4f_1_computePosDofBlendMatrix(const void
  *mech, size_t stageIdx, size_t primIdx, const double *state, int partialType,
  double *matrix)
{
  (void) mech;
  (void) stageIdx;
  (void) primIdx;
  (void) state;
  (void) partialType;
  (void) matrix;
  switch ((stageIdx * 6 + primIdx))
  {
  }
}

void DinamicaNonLineare_Controllo_4531be4f_1_computeVelDofBlendMatrix(const void
  *mech, size_t stageIdx, size_t primIdx, const double *state, int partialType,
  double *matrix)
{
  (void) mech;
  (void) stageIdx;
  (void) primIdx;
  (void) state;
  (void) partialType;
  (void) matrix;
  switch ((stageIdx * 6 + primIdx))
  {
  }
}

void DinamicaNonLineare_Controllo_4531be4f_1_projectPartiallyTargetedPos(const
  void *mech, size_t stageIdx, size_t primIdx, const double *origState, int
  partialType, double *state)
{
  (void) mech;
  (void) stageIdx;
  (void) primIdx;
  (void) origState;
  (void) partialType;
  (void) state;
  switch ((stageIdx * 6 + primIdx))
  {
  }
}

void DinamicaNonLineare_Controllo_4531be4f_1_propagateMotion(const void *mech,
  const RuntimeDerivedValuesBundle *rtdv, const double *state, double
  *motionData)
{
  const double *rtdvd = rtdv->mDoubles.mValues;
  const int *rtdvi = rtdv->mInts.mValues;
  double xx[10];
  (void) mech;
  (void) rtdvd;
  (void) rtdvi;
  xx[0] = 0.5;
  xx[1] = xx[0] * state[0];
  xx[2] = sin(xx[1]);
  xx[3] = xx[0] * state[1];
  xx[4] = sin(xx[3]);
  xx[5] = xx[2] * xx[4];
  xx[6] = xx[0] * state[2];
  xx[0] = sin(xx[6]);
  xx[7] = cos(xx[6]);
  xx[6] = cos(xx[1]);
  xx[1] = cos(xx[3]);
  xx[3] = xx[6] * xx[1];
  xx[8] = xx[5] * xx[0] - xx[7] * xx[3];
  xx[9] = xx[1] * xx[2];
  xx[1] = xx[6] * xx[4];
  xx[2] = xx[7] * xx[9] + xx[1] * xx[0];
  xx[4] = xx[9] * xx[0] - xx[7] * xx[1];
  xx[1] = xx[3] * xx[0] + xx[7] * xx[5];
  xx[3] = 0.0;
  xx[5] = 1.0;
  xx[6] = 2.0;
  motionData[0] = xx[8];
  motionData[1] = - xx[2];
  motionData[2] = xx[4];
  motionData[3] = - xx[1];
  motionData[4] = xx[3];
  motionData[5] = xx[3];
  motionData[6] = xx[3];
  motionData[7] = (xx[5] - (xx[4] * xx[4] + xx[1] * xx[1]) * xx[6]) * state[3] +
    xx[6] * xx[7] * xx[0] * state[4];
  motionData[8] = xx[6] * (xx[1] * xx[8] - xx[2] * xx[4]) * state[3] + (xx[5] -
    xx[6] * xx[0] * xx[0]) * state[4];
  motionData[9] = xx[6] * (xx[4] * xx[8] + xx[2] * xx[1]) * state[3] + state[5];
  motionData[10] = xx[3];
  motionData[11] = xx[3];
  motionData[12] = xx[3];
}

size_t DinamicaNonLineare_Controllo_4531be4f_1_computeAssemblyError(const void
  *mech, const RuntimeDerivedValuesBundle *rtdv, size_t constraintIdx, const int
  *modeVector, const double *motionData, double *error)
{
  (void) mech;
  (void)rtdv;
  (void) modeVector;
  (void) motionData;
  (void) error;
  switch (constraintIdx)
  {
  }

  return 0;
}

size_t DinamicaNonLineare_Controllo_4531be4f_1_computeAssemblyJacobian(const
  void *mech, const RuntimeDerivedValuesBundle *rtdv, size_t constraintIdx,
  boolean_T forVelocitySatisfaction, const double *state, const int *modeVector,
  const double *motionData, double *J)
{
  (void) mech;
  (void) rtdv;
  (void) state;
  (void) modeVector;
  (void) forVelocitySatisfaction;
  (void) motionData;
  (void) J;
  switch (constraintIdx)
  {
  }

  return 0;
}

size_t DinamicaNonLineare_Controllo_4531be4f_1_computeFullAssemblyJacobian(const
  void *mech, const RuntimeDerivedValuesBundle *rtdv, const double *state, const
  int *modeVector, const double *motionData, double *J)
{
  const double *rtdvd = rtdv->mDoubles.mValues;
  const int *rtdvi = rtdv->mInts.mValues;
  (void) mech;
  (void) rtdvd;
  (void) rtdvi;
  (void) state;
  (void) modeVector;
  (void) motionData;
  (void) J;
  return 0;
}

int DinamicaNonLineare_Controllo_4531be4f_1_isInKinematicSingularity(const void *
  mech, const RuntimeDerivedValuesBundle *rtdv, size_t constraintIdx, const int *
  modeVector, const double *motionData)
{
  (void) mech;
  (void) rtdv;
  (void) modeVector;
  (void) motionData;
  switch (constraintIdx)
  {
  }

  return 0;
}

void DinamicaNonLineare_Controllo_4531be4f_1_convertStateVector(const void
  *asmMech, const RuntimeDerivedValuesBundle *rtdv, const void *simMech, const
  double *asmState, const int *asmModeVector, const int *simModeVector, double
  *simState)
{
  const double *rtdvd = rtdv->mDoubles.mValues;
  const int *rtdvi = rtdv->mInts.mValues;
  (void) asmMech;
  (void) rtdvd;
  (void) rtdvi;
  (void) simMech;
  (void) asmModeVector;
  (void) simModeVector;
  simState[0] = asmState[0];
  simState[1] = asmState[1];
  simState[2] = asmState[2];
  simState[3] = asmState[3];
  simState[4] = asmState[4];
  simState[5] = asmState[5];
}
