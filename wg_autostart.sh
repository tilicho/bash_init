systemctl enable wg-quick@wg0.service
systemctl daemon-reload
systemctl start wg-quick@wg0

