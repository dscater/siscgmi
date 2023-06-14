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
                                    v-model="entrada_herramienta.factura"
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
                                        'text-danger': errors.herramienta_id,
                                    }"
                                    >Seleccionar Herramienta/Equipo de
                                    protección*</label
                                >

                                <el-select
                                    class="w-100"
                                    :class="{
                                        'is-invalid': errors.herramienta_id,
                                    }"
                                    v-model="entrada_herramienta.herramienta_id"
                                    filterable
                                    placeholder="Herramienta/Equipo de protección"
                                >
                                    <el-option
                                        v-for="item in listHerramientas"
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
                                    v-if="errors.herramienta_id"
                                    v-text="errors.herramienta_id[0]"
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
                                    v-model="entrada_herramienta.cantidad"
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
                                        'text-danger': errors.unidad_medida,
                                    }"
                                    >Unidad de medida</label
                                >
                                <el-input
                                    placeholder="Unidad de medida"
                                    :class="{
                                        'is-invalid': errors.unidad_medida,
                                    }"
                                    v-model="entrada_herramienta.unidad_medida"
                                    clearable
                                >
                                </el-input>
                                <span
                                    class="error invalid-feedback"
                                    v-if="errors.unidad_medida"
                                    v-text="errors.unidad_medida[0]"
                                ></span>
                            </div>
                            <div class="form-group col-md-6">
                                <label
                                    :class="{
                                        'text-danger': errors.precio,
                                    }"
                                    >Precio unitario*</label
                                >
                                <el-input
                                    type="number"
                                    min="0.01"
                                    placeholder="Precio de compra"
                                    :class="{
                                        'is-invalid': errors.precio,
                                    }"
                                    v-model="entrada_herramienta.precio"
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
                                    v-model="entrada_herramienta.total"
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
                                    v-model="entrada_herramienta.fecha"
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
        entrada_herramienta: {
            type: Object,
            default: {
                id: 0,
                factura: "",
                herramienta_id: "",
                cantidad: "",
                unidad_medida: "",
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
        entrada_herramienta(newVal) {
            this.oEntradaHerramienta = newVal;
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
            listHerramientas: [],
            oEntradaHerramienta: this.entrada_herramienta,
        };
    },
    mounted() {
        this.bModal = this.muestra_modal;
        this.getEntradaHerramientas();
    },
    methods: {
        getEntradaHerramientas() {
            axios.get("/admin/herramientas").then((response) => {
                this.listHerramientas = response.data.herramientas;
            });
        },
        setRegistroModal() {
            this.enviando = true;
            try {
                this.textoBtn = "Enviando...";
                let url = "/admin/entrada_herramientas";
                let config = {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                };
                let formdata = new FormData();
                if (
                    this.entrada_herramienta.factura &&
                    this.entrada_herramienta.factura.trim() != ""
                ) {
                    formdata.append(
                        "factura",
                        this.entrada_herramienta.factura
                    );
                }
                if (this.entrada_herramienta.herramienta_id) {
                    formdata.append(
                        "herramienta_id",
                        this.entrada_herramienta.herramienta_id
                    );
                }
                if (this.entrada_herramienta.cantidad) {
                    formdata.append(
                        "cantidad",
                        this.entrada_herramienta.cantidad
                    );
                }
                if (
                    this.entrada_herramienta.unidad_medida &&
                    this.entrada_herramienta.unidad_medida.trim() != ""
                ) {
                    formdata.append(
                        "unidad_medida",
                        this.entrada_herramienta.unidad_medida
                    );
                }
                if (this.entrada_herramienta.precio) {
                    formdata.append("precio", this.entrada_herramienta.precio);
                }
                if (this.entrada_herramienta.total) {
                    formdata.append("total", this.entrada_herramienta.total);
                }
                if (
                    this.entrada_herramienta.fecha &&
                    this.entrada_herramienta.fecha.trim() != ""
                ) {
                    formdata.append("fecha", this.entrada_herramienta.fecha);
                }
                if (this.accion == "edit") {
                    url =
                        "/admin/entrada_herramientas/" +
                        this.entrada_herramienta.id;
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
                            this.limpiaEntradaHerramienta();
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
        limpiaEntradaHerramienta() {
            this.errors = [];
            // this.oEntradaHerramienta.herramienta_id = "";
        },
        calculaTotal() {
            if (
                this.entrada_herramienta.cantidad != "" &&
                this.entrada_herramienta.precio
            ) {
                this.entrada_herramienta.total = (
                    parseFloat(this.entrada_herramienta.cantidad) *
                    parseFloat(this.entrada_herramienta.precio)
                ).toFixed(2);
            } else {
                this.entrada_herramienta.total = parseFloat(0).toFixed(2);
            }
        },
    },
};
</script>

<style></style>
