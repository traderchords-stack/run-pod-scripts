#!/bin/bash
# ============================================================
#  MY WAN 2.2 WORKFLOW - FULL SETUP SCRIPT
#  Run this in the RunPod terminal on a fresh pod
#  Usage: bash setup_my_workflow.sh
# ============================================================

echo ""
echo "============================================================"
echo "  Starting My Wan 2.2 Workflow Setup..."
echo "============================================================"
echo ""

# --- Directories ---
echo "[1/3] Creating directories..."
mkdir -p /workspace/ComfyUI/models/loras/WAN
mkdir -p /workspace/ComfyUI/models/unet
mkdir -p /workspace/ComfyUI/models/text_encoders
mkdir -p /workspace/ComfyUI/models/clip_vision
echo "Done."
echo ""

# --- Hugging Face Models ---
echo "[2/3] Downloading models from Hugging Face..."
echo ""

pip install -q huggingface_hub

echo "  -> Wan 2.2 UNET (High Noise GGUF)..."
hf download bullerwins/Wan2.2-I2V-A14B-GGUF \
  wan2.2_i2v_high_noise_14B_Q6_K.gguf \
  --local-dir /workspace/ComfyUI/models/unet

echo "  -> Wan 2.2 UNET (Low Noise GGUF)..."
hf download bullerwins/Wan2.2-I2V-A14B-GGUF \
  wan2.2_i2v_low_noise_14B_Q6_K.gguf \
  --local-dir /workspace/ComfyUI/models/unet

echo "  -> Text Encoder (UMT5 XXL fp8)..."
hf download Comfy-Org/Wan_2.2_ComfyUI_Repackaged \
  split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors \
  --local-dir /workspace/ComfyUI/models/text_encoders

echo "  -> Clip Vision..."
hf download Comfy-Org/Wan_2.1_ComfyUI_repackaged \
  split_files/clip_vision/clip_vision_h.safetensors \
  --local-dir /workspace/ComfyUI/models/clip_vision

echo "  -> LightX2V LoRA..."
hf download Kijai/WanVideo_comfy \
  Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank16_bf16.safetensors \
  --local-dir /workspace/ComfyUI/models/loras/WAN

echo "  -> Moving LightX2V to correct location..."
mv /workspace/ComfyUI/models/loras/WAN/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank16_bf16.safetensors \
   /workspace/ComfyUI/models/loras/WAN/lightx2v_I2V_14B_480p_cfg_step_distill_rank16_bf16.safetensors
rm -rf /workspace/ComfyUI/models/loras/WAN/Lightx2v

echo "  -> DR34ML4Y LoRAs (High + Low V2)..."
hf download gbrx/GonzaLomo \
  DR34ML4Y_I2V_14B_HIGH_V2.safetensors \
  --local-dir /workspace/ComfyUI/models/loras/WAN

hf download gbrx/GonzaLomo \
  DR34ML4Y_I2V_14B_LOW_V2.safetensors \
  --local-dir /workspace/ComfyUI/models/loras/WAN

echo "  -> Genitals Helper LoRA..."
hf download gbrx/GonzaLomo \
  genitals_helper_v1.0_e219.safetensors \
  --local-dir /workspace/ComfyUI/models/loras/WAN

echo ""

# --- CivitAI LoRAs ---
echo "[3/3] Downloading LoRAs from CivitAI..."
echo ""

CIVITAI_TOKEN="958ecd1449dc90fb0f7857f854f747da"

echo "  -> FrenchKiss High Noise LoRA..."
curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /workspace/ComfyUI/models/loras/WAN/WAN2.2-FrenchKiss_HighNoise.safetensors \
  "https://civitai.com/api/download/models/2445168?type=Model&format=SafeTensor"

echo "  -> FrenchKiss Low Noise LoRA..."
curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /workspace/ComfyUI/models/loras/WAN/WAN2.2-FrenchKiss_LowNoise.safetensors \
  "https://civitai.com/api/download/models/2445176?type=Model&format=SafeTensor"

echo ""
echo "============================================================"
echo "  All done! Your Wan 2.2 workflow is ready to go."
echo "  Models are in /workspace/ComfyUI/models/"
echo "  LoRAs are in /workspace/ComfyUI/models/loras/WAN/"
echo "============================================================"
echo ""
