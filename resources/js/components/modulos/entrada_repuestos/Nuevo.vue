<template>
    <div
        class="modal fade"
        :class="{ show: bModal }"
        id="modal-default"
        aria-modal="true"
        role="dialog"
    >
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-primary">
                    <h4 class="modal-title" v-text="tituloModal"></h4>
                    <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-label="Close"
                        @click="cierraModal"
                    >
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.factura,
                                    }"
                                    >Factura</label
                                >
                                <el-input
                                    placeholder="Factura"
                                    :class="{
                                        'is-invalid': errors.factura,
                                    }"
                                    v-model="entrada_repuesto.factura"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.factura"
                                    v-text="errors.factura[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.repuesto_id,
                                    }"
                                    >Seleccionar Repuesto/Insumo*</label
                                >

                                <el-select
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.repuesto_id,
                                    }"
                                    v-model="entrada_repuesto.repuesto_id"
                                    filterable
                                    placeholder="Repuesto/Equipo de protección"
                                >
                                    <el-option
                                        v-for="item in listRepuestos"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="
                                            item.codigo + ' | ' + item.nombre
                                        "
                                    >
                                    </el-option>
                                </el-select>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.repuesto_id"
                                    v-text="errors.repuesto_id[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.cantidad,
                                    }"
                                    >Cantidad*</label
                                >
                                <el-input
                                    type="number"
                                    min="0.01"
                                    placeholder="Cantidad"
                                    :class="{ 'is-invalid': errors.cantidad }"
                                    v-model="entrada_repuesto.cantidad"
                                    clearable
                                    @change="calculaTotal"
                                    @keyup.native="calculaTotal"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.cantidad"
                                    v-text="errors.cantidad[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.precio,
                                    }"
                                    >Precio*</label
                                >
                                <el-input
                                    type="number"
                                    min="0.01"
                                    placeholder="Precio de compra"
                                    :class="{
                                        'is-invalid': errors.precio,
                                    }"
                                    v-model="entrada_repuesto.precio"
                                    clearable
                                    @change="calculaTotal"
                                    @keyup.native="calculaTotal"
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.precio"
                                    v-text="errors.precio[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.total,
                                    }"
                                    >Total</label
                                >
                                <el-input
                                    placeholder="Total"
                                    :class="{
                                        'is-invalid': errors.total,
                                    }"
                                    v-model="entrada_repuesto.total"
                                    clearable
                                    readonly
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.total"
                                    v-text="errors.total[0]"
                                ></span>
                            </div>

                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.fecha,
                                    }"
                                    >Fecha de entrada*</label
                                >
                                <el-input
                                    type="date"
                                    placeholder="Fecha de entrada"
                                    :class="{
                                        'is-invalid': errors.fecha,
                                    }"
                                    v-model="entrada_repuesto.fecha"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.fecha"
                                    v-text="errors.fecha[0]"
                                ></span>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-between">
                    <button
                        type="button"
                        class="btn btn-default"
                        data-dismiss="modal"
                        @click="cierraModal"
                    >
                        Cerrar
                    </button>
                    <el-button
                        type="primary"
                        class="bg-primary"
                        :loading="enviando"
                        @click="setRegistroModal()"
                        >{{ textoBoton }}</el-button
                    >
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
    props: {
        muestra_modal: {
            type: Boolean,
            default: false,
        },
        accion: {
            type: String,
            default: "nuevo",
        },
        entrada_repuesto: {
            type: Object,
            default: {
                id: 0,
                factura: "",
                repuesto_id: "",
                cantidad: "",
                precio: "",
                total: "",
                fecha: "",
            },
        },
    },
    watch: {
        muestra_modal: function (newVal, oldVal) {
            this.errors = [];
            if (newVal) {
                this.bModal = true;
            } else {
                this.bModal = false;
            }
        },
        entrada_repuesto(newVal) {
            this.oEntradaRepuesto = newVal;
        },
    },
    computed: {
        tituloModal() {
            if (this.accion == "nuevo") {
                return "NUEVO REGISTRO";
            } else {
                return "MODIFICAR REGISTRO";
            }
        },
        textoBoton() {
            if (this.accion == "nuevo") {
                return "Registrar";
            } else {
                return "Actualizar";
            }
        },
    },
    data() {
        return {
            user: JSON.parse(localStorage.getItem("user")),
            bModal: this.muestra_modal,
            enviando: false,
            errors: [],
            listRepuestos: [],
            oEntradaRepuesto: this.entrada_repuesto,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getEntradaRepuestos();
    },
    methods: {
        getEntradaRepuestos() {
            axios.get("/admin/repuestos").then((response) => {
                this.listRepuestos = response.data.repuestos;
            });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/entrada_repuestos";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (
                    this.entrada_repuesto.factura &&
                    this.entrada_repuesto.factura.trim() != ""
                ) {
                    formdata.append("factura", this.entrada_repuesto.factura);
                }
                if (this.entrada_repuesto.repuesto_id) {
                    formdata.append(
                        "repuesto_id",
                        this.entrada_repuesto.repuesto_id
                    );
                }
                if (this.entrada_repuesto.cantidad) {
                    formdata.append("cantidad", this.entrada_repuesto.cantidad);
                }
                if (this.entrada_repuesto.precio) {
                    formdata.append("precio", this.entrada_repuesto.precio);
                }
                if (this.entrada_repuesto.total) {
                    formdata.append("total", this.entrada_repuesto.total);
                }
                if (
                    this.entrada_repuesto.fecha &&
                    this.entrada_repuesto.fecha.trim() != ""
                ) {
                    formdata.append("fecha", this.entrada_repuesto.fecha);
                }
                if (this.accion == "edit") {
                    url =
                        "/admin/entrada_repuestos/" + this.entrada_repuesto.id;
                    formdata.append("_method", "PUT");
                }
                axios
                    .post(url, formdata, config)
                    .then((res) => {
                        this.enviando = false;
                        if (res.data.sw) {
                            Swal.fire({
                                icon: "success",
                                title: res.data.msj,
                                showConfirmButton: false,
                                timer: 1500,
                            });
                            this.limpiaEntradaRepuesto();
                            this.$emit("envioModal");
                            this.errors = [];
                            if (this.accion == "edit") {
                                this.textoBtn = "Actualizar";
                            } else {
                                this.textoBtn = "Registrar";
                            }
                        } else {
                            Swal.fire({
                                icon: "info",
                                title: "Atención",
                                html: res.data.msj,
                                showConfirmButton: false,
                                timer: 2000,
                            });
                        }
                    })
                    .catch((error) => {
                        this.enviando = false;
                        if (this.accion == "edit") {
                            this.textoBtn = "Actualizar";
                        } else {
                            this.textoBtn = "Registrar";
                        }
                        if (error.response) {
                            if (error.response.status === 422) {
                                this.errors = error.response.data.errors;
                            }
                            if (
                                error.response.status === 420 ||
                                error.response.status === 419 ||
                                error.response.status === 401
                            ) {
                                window.location = "/";
                            }
                            if (error.response.status === 500) {
                                Swal.fire({
                                    icon: "error",
                                    title: "Error",
                                    html: error.response.data.message,
                                    showConfirmButton: false,
                                    timer: 2000,
                                });
                            }
                        }
                    });
            } catch (e) {
                this.enviando = false;
                console.log(e);
            }
        },
        // Dialog/modal
        cierraModal() {
            this.bModal = false;
            this.$emit("close");
        },
        limpiaEntradaRepuesto() {
            this.errors = [];
            // this.oEntradaRepuesto.repuesto_id = "";
        },
        calculaTotal() {
            if (
                this.entrada_repuesto.cantidad != "" &&
                this.entrada_repuesto.precio
            ) {
                this.entrada_repuesto.total = (
                    parseFloat(this.entrada_repuesto.cantidad) *
                    parseFloat(this.entrada_repuesto.precio)
                ).toFixed(2);
            } else {
                this.entrada_repuesto.total = parseFloat(0).toFixed(2);
            }
        },
    },
};
</script>

<style></style>
