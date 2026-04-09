#!/bin/bash
# ============================================================
#  YET ANOTHER WORKFLOW (YAW) - CUSTOM STARTUP SCRIPT
#
#  This script runs automatically when your YAW pod boots.
#  Host this file on GitHub and paste the raw URL into the
#  YAW template's custom script environment variable.
#
#  The YAW template already downloads the base Wan 2.2 models,
#  so this script is just for YOUR custom LoRAs on top of that.
#
#  HOW TO ADD A LORA:
#  - From CivitAI: copy the curl block below and update the
#    model ID and output filename
#  - From HuggingFace: use the hf download command pattern
# ============================================================

echo ""
echo "============================================================"
echo "  Running YAW Custom Startup Script..."
echo "============================================================"
echo ""

# --- Directories ---
mkdir -p /ComfyUI/models/loras

# Pull CivitAI token from RunPod environment variable
# Set this in your pod's Environment Variables as: civitai_token = your_token_here
CIVITAI_TOKEN="${civitai_token}"

if [ -z "$CIVITAI_TOKEN" ]; then
  echo "WARNING: civitai_token environment variable not set."
  echo "CivitAI LoRA downloads will fail. Set it in your pod's environment variables."
  echo ""
fi

# ============================================================
#  ADD YOUR CUSTOM LORAS BELOW THIS LINE
#  Copy and paste a block for each LoRA you want to add
# ============================================================

echo "  -> Hard Cut 3 Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/hard_cut_3_wan_i2v_high.safetensors \
  "https://civitai.com/api/download/models/2446376?type=Model&format=SafeTensor"

echo "  -> Gagging Wan I2v High Lora ..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_high_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407012?type=Model&format=SafeTensor"
  
echo "  -> Gagging Wan I2V Low LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_low_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407028?type=Model&format=SafeTensor"

echo "  -> Dr34ml4y NSFW Wan I2V Low LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_LOW_V2.safetensors \
  "https://civitai.com/api/download/models/2553271?type=Model&format=SafeTensor"

echo "  -> Dr34ml4y NSFW Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_HIGH_V2.safetensors \
  "https://civitai.com/api/download/models/2553151?type=Model&format=SafeTensor"
  
echo "  -> SH00TZ Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/sh00tz_HN_75.safetensors \
  "https://civitai.com/api/download/models/2731730?type=Model&format=SafeTensor"

echo "  -> SH00TZ Wan I2V Low LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/sh00tz_LN_75.safetensors \
  "https://civitai.com/api/download/models/2731744?type=Model&format=SafeTensor"

echo "  -> Facials Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/facials_epoch_50.safetensors \
  "https://civitai.com/api/download/models/1542133?type=Model&format=SafeTensor"

echo "  ->  Thiccum Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/wan-thiccum-v3.safetensors \
  "https://civitai.com/api/download/models/1860691?type=Model&format=SafeTensor"

echo "  ->  Anime Cumshot Wan I2V Low LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/56Low noise-Cumshot Aesthetics.safetensors \
  "https://civitai.com/api/download/models/2116027?type=Model&format=SafeTensor"
  
echo "  ->  Anime Cumshot Wan I2V High LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/23High noise-Cumshot Aesthetics.safetensors \
  "https://civitai.com/api/download/models/2116008?type=Model&format=SafeTensor"

echo "  ->  Wan Cumshot I2V LoRA..."
curl -L \
  -H "Authorization: Bearer cde9ea9e6fb29a0c5fda3358583224a4" \
  -o /ComfyUI/models/loras/wan_cumshot_i2v.safetensors \
  "https://civitai.com/api/download/models/1602715?type=Model&format=SafeTensor"
  
echo "  -> Oral Insertion High LoRA..."
curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-high-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-high-oral-insertion-v1.0.safetensors?download=true"

echo "  -> Oral Insertion Low LoRA..."
curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-low-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-low-oral-insertion-v1.0.safetensors?download=true"

# --- CIVITAI LORA TEMPLATE ---
# Uncomment and fill in to add a CivitAI LoRA:
#
# echo "  -> Your LoRA Name Here..."
# curl -L \
#   -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
#   -o /ComfyUI/models/loras/YOUR_LORA_FILENAME.safetensors \
#   "https://civitai.com/api/download/models/REPLACE_WITH_MODEL_ID?type=Model&format=SafeTensor"


# --- HUGGINGFACE LORA TEMPLATE ---
# Uncomment and fill in to add a HuggingFace LoRA:
#
# echo "  -> Your LoRA Name Here..."
# hf download REPO/NAME \
#   filename.safetensors \
#   --local-dir /ComfyUI/models/loras


# ============================================================
#  ADD YOUR CUSTOM LORAS ABOVE THIS LINE
# ============================================================

echo ""
echo "============================================================"
echo "  YAW custom startup complete."
echo "============================================================"
echo ""
