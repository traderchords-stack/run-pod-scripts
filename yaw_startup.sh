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

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/hard_cut_3_wan_i2v_high.safetensors \
  "https://civitai.com/api/download/models/2446376?type=Model&format=SafeTensor"
echo "  ->  hard_cut_3_wan_i2v_high..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_high_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407012?type=Model&format=SafeTensor"
echo "  ->  wan_2.2_i2v_gagging_high_v1.0..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2.2_i2v_gagging_low_v1.0.safetensors \
  "https://civitai.com/api/download/models/2407028?type=Model&format=SafeTensor"
echo "  ->  wan_2.2_i2v_gagging_low_v1.0..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_LOW_V2.safetensors \
  "https://civitai.com/api/download/models/2553271?type=Model&format=SafeTensor"
echo "  ->  DR34ML4Y_I2V_14B_LOW_V2..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/DR34ML4Y_I2V_14B_HIGH_V2.safetensors \
  "https://civitai.com/api/download/models/2553151?type=Model&format=SafeTensor"
echo "  ->  DR34ML4Y_I2V_14B_HIGH_V2..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/sh00tz_HN_75.safetensors \
  "https://civitai.com/api/download/models/2731730?type=Model&format=SafeTensor"
echo "  ->  sh00tz_HN_75..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/sh00tz_LN_75.safetensors \
  "https://civitai.com/api/download/models/2731744?type=Model&format=SafeTensor"
echo "  ->  sh00tz_LN_75..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/facials_epoch_50.safetensors \
  "https://civitai.com/api/download/models/1542133?type=Model&format=SafeTensor"
echo "  ->  facials_epoch_50..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan-thiccum-v3.safetensors \
  "https://civitai.com/api/download/models/1860691?type=Model&format=SafeTensor"
echo "  ->  wan-thiccum-v3..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/breasts-wan-e7.safetensors \
  "https://civitai.com/api/download/models/2156804?type=Model&format=SafeTensor"
echo "  ->  breasts-wan-e7..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_cumshot_i2v.safetensors \
  "https://civitai.com/api/download/models/1602715?type=Model&format=SafeTensor"
echo "  ->  wan_cumshot_i2v..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/SmoothMixAnimation_High.safetensors \
  "https://civitai.com/api/download/models/2309690?type=Model&format=SafeTensor"
echo "  ->  SmoothMixAnimation_High..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/SmoothMixAnimation_Low.safetensors \
  "https://civitai.com/api/download/models/2309689?type=Model&format=SafeTensor"
echo "  ->  SmoothMixAnimation_Low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2_2_anime_cumshot_aesthetics_low.safetensors \
  "https://civitai.com/api/download/models/2116027?type=Model&format=SafeTensor"
echo "  ->  wan_2_2_anime_cumshot_aesthetics_low..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan_2_2_anime_cumshot_aesthetics_high.safetensors \
  "https://civitai.com/api/download/models/2116008?type=Model&format=SafeTensor"
echo "  ->  wan_2_2_anime_cumshot_aesthetics_high..."

curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-high-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-high-oral-insertion-v1.0.safetensors?download=true"
echo "  ->  wan2.2-i2v-high-oral-insertion-v1.0..."

curl -L \
  -o /ComfyUI/models/loras/wan2.2-i2v-low-oral-insertion-v1.0.safetensors \
  "https://huggingface.co/rahul7star/wan2.2Lora/resolve/1d1e553d07c1bb0e91765752413c4857e31df299/wan2.2/wan2.2-i2v-low-oral-insertion-v1.0.safetensors?download=true"
echo "  ->  wan2.2-i2v-low-oral-insertion-v1.0..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/SmoothXXXAnimation_High.safetensors \
  "https://civitai.red/api/download/models/2376136?type=Model&format=SafeTensor"
echo "  ->  SmoothXXXAnimation_High..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan22-bbcdeepthroat-115epoc-high-k3nk.safetensors \
  "https://civitai.red/api/download/models/2370687?type=Model&format=SafeTensor"
echo "  ->  wan22-bbcdeepthroat-115epoc-high-k3nk..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan22-bbcdeepthroat-155epoc-low-720-k3nk..safetensors \
  "https://civitai.red/api/download/models/2370744?type=Model&format=SafeTensor"
echo "  ->  wan22-bbcdeepthroat-155epoc-low-720-k3nk...."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan22-ultimatedeepthroat-i2v-102epoc-high-k3nk.safetensors \
  "https://civitai.red/api/download/models/2325788?type=Model&format=SafeTensor"
echo "  ->  wan22-ultimatedeepthroat-i2v-102epoc-high-k3nk..."

curl -L \
  -H "Authorization: Bearer ${CIVITAI_TOKEN}" \
  -o /ComfyUI/models/loras/wan22-ultimatedeepthroat-I2V-101epoc-low-k3nk.safetensors \
  "https://civitai.red/api/download/models/2191446?type=Model&format=SafeTensor"
echo "  ->  wan22-ultimatedeepthroat-I2V-101epoc-low-k3nk..."

ADD YOUR CUSTOM LORAS ABOVE THIS LINE
# ============================================================
echo ""
echo "============================================================"
echo "  YAW custom startup complete."
echo "============================================================"
echo ""
